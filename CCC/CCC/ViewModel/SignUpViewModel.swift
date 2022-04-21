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
    
    private let authManager: AuthManager
    private let mediaManager: MediaManager
    private let userManager: UserManager
    
    private let compressionQuality: CGFloat = 0.1
    
    @Published var email: String
    @Published var password: String
    @Published var firstName: String
    @Published var lastName: String
    @Published var profileImage: UIImage?
    @Published var signUpSuccessful = false
    
    
    init(authManager: AuthManager, mediaManager: MediaManager, userManager: UserManager) {
        self.authManager = authManager
        self.mediaManager = mediaManager
        self.userManager = userManager
        email = ""; password = ""; firstName = ""; lastName = ""
    }
    
    func signUp() {
        // FIXME: Check whether email and password have valid values
        
        // Got both email and password, now create the account
        createUser(withEmail: email, password: password)
    }
    
    private func createUser(withEmail email: String, password: String) {
        authManager.createUser(withEmail: email, password: password) { userId, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let userId = userId else {
                return
            }
            
            let user = User(id: userId, email: email, firstName: self.firstName, lastName: self.lastName)
            
            // Upload profile image to data store
            self.uploadProfileImage(for: user)
        }
    }
    
    private func uploadProfileImage(for user: User) {
        guard let profileImage = profileImage,
              let profileImageData = profileImage.jpegData(compressionQuality: compressionQuality) else {
            return
        }
        
        mediaManager.uploadProfileImage(withData: profileImageData, for: user) { profilePhotoUrlString, error in
            // An error uploading the image.
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            // Get the String for profile Url.
            guard let profilePhotoUrlString = profilePhotoUrlString else { return }
            
            let userToSaveInFirestore = User(id: user.id, email: user.email, firstName: user.firstName,
                                             lastName: user.lastName, phoneNumber: nil,
                                             profilePhotoUrlString: profilePhotoUrlString)
            
            self.saveUserInDatastore(userToSaveInFirestore)
        }
    }
    
    private func saveUserInDatastore(_ user: User) {
        userManager.saveUser(user: user) { error in
            // There is an error saving user in Data Store.
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            // Show a message that the sign up is successful.
            self.signUpSuccessful = true
        }
    }
    
}
