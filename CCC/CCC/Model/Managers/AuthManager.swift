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

protocol AuthManager {
    func createUser(withEmail: String, password: String, completion: @escaping (_ userId: String?, Error?) -> Void)
    func signIn(withEmail: String, password: String, completion: @escaping (_ userId: String?, SignInError?) -> Void)
}

class AuthManagerImp: AuthManager {
    
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
    
}
