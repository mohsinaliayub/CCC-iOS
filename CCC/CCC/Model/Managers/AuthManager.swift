//
//  AuthManager.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 19.04.22.
//

import Foundation
import Firebase

enum SignInError: Error {
    case wrongPassword
    case wrongEmail
    
    var description: String {
        switch self {
        case .wrongPassword: return "The provided password is invalid."
        case .wrongEmail: return "No user account exists with this email."
        }
    }
}

protocol AuthManager: AnyObject {
    var signedInUserId: String? { get }
    var signedInUser: User? { get set }
    
    func createUser(withEmail: String, password: String, completion: @escaping (_ userId: String?, Error?) -> Void)
    func signIn(withEmail: String, password: String, completion: @escaping (_ userId: String?, SignInError?) -> Void)
    func signOut(completion: @escaping (Error?) -> Void)
}

class AuthManagerImp: AuthManager {
    
    private let signedInUserKeyForUserDefaults = "signedInUser"
    
    var signedInUserId: String? {
        Auth.auth().currentUser?.uid
    }
    
    var signedInUser: User? {
        get {
            guard Auth.auth().currentUser != nil else { return nil }
            
            guard let jsonData = UserDefaults.standard.data(forKey: signedInUserKeyForUserDefaults),
                  let user = try? JSONDecoder().decode(User.self, from: jsonData) else {
                return nil
            }
            
            return user
        }
        set {
            guard let user = newValue else {
                UserDefaults.standard.removeObject(forKey: signedInUserKeyForUserDefaults)
                UserDefaults.standard.synchronize()
                return
            }
            
            guard let json = try? JSONEncoder().encode(user) else {
                return
            }
            
            UserDefaults.standard.set(json, forKey: signedInUserKeyForUserDefaults)
        }
    }
    
    func createUser(withEmail email: String, password: String, completion: @escaping (_ userId: String?, Error?) -> Void) {
        // create a user account on Firebase
        Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in
            guard let authDataResult = authDataResult, error == nil else {
                completion(nil, error)
                return
            }
            
            // send a verification email for user to confirm their account
            authDataResult.user.sendEmailVerification { error in
                completion(authDataResult.user.uid, error)
            }
        }
    }
    
    func signIn(withEmail email: String, password: String, completion: @escaping (String?, SignInError?) -> Void) {
        // Sign In an existing user with Firebase Authentication
        Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
            guard let authDataResult = authDataResult, error == nil else {
                guard let nsError = error as? NSError else {
                    return
                }
                if nsError.code == AuthErrorCode.wrongPassword.rawValue {
                    completion(nil, .wrongPassword)
                } else if nsError.code == AuthErrorCode.userNotFound.rawValue {
                    completion(nil, .wrongEmail)
                }
                
                return
            }

            // FIXME: User is not verified, send an error back for user to verify their email
            let userId = authDataResult.user.uid
            completion(userId, nil)
        }
    }
    
    func signOut(completion: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            signedInUser = nil
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
}
