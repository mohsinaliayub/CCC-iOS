//
//  SignUpViewModel.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 19.04.22.
//

import Foundation
import UIKit

class SignUpViewModel: ObservableObject {
    
    let profileImagePlaceholder = "person.crop.circle"
    
    @Published var email: String
    @Published var password: String
    @Published var firstName: String
    @Published var lastName: String
    @Published var profileImage: UIImage?
    
    private let authManager: AuthManager
    
    init(authManager: AuthManager) {
        self.authManager = authManager
        email = ""
        password = ""
        firstName = ""
        lastName = ""
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
    
    func choosePictureFromGallery() {
        
    }
    
    
}
