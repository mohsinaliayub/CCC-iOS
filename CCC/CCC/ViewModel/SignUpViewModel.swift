//
//  SignUpViewModel.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 19.04.22.
//

import Foundation

class SignUpViewModel: ObservableObject {
    
    @Published var email: String
    @Published var password: String
    
    private let authManager: AuthManager
    
    init(authManager: AuthManager) {
        self.authManager = authManager
        email = ""
        password = ""
    }
    
    func signUp() {
        // FIXME: Check whether email and password have valid values
        
        // got both email and password, now create the account
//        authManager.createUser(withEmail: email, password: password) { error in
//            // do something useful with error
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//        }
    }
    
    
}
