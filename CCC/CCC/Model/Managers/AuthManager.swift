//
//  AuthManager.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 19.04.22.
//

import Foundation
import Firebase

protocol AuthManager {
    func createUser(withEmail: String, password: String, completion: @escaping (Error?) -> Void)
}

class AuthManagerImp: AuthManager {
    
    func createUser(withEmail email: String, password: String, completion: @escaping (Error?) -> Void) {
        // create a user account on Firebase
        Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in
            guard let authDataResult = authDataResult, error == nil else {
                completion(error)
                return
            }
            
            // send a verification email for user to confirm their account
            authDataResult.user.sendEmailVerification { error in
                completion(error)
            }
        }
    }
    
}
