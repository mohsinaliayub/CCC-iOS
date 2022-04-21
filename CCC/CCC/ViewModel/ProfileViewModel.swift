//
//  ProfileViewModel.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 21.04.22.
//

import Foundation
import UIKit

class ProfileViewModel: ObservableObject {
    
    let profileImagePlaceholder = "person.crop.circle"
    @Published var signedInUser: User?
    @Published var profileImage: UIImage?
    
    private let authManager: AuthManager
    private let mediaManager: MediaManager
    
    init(authManager: AuthManager, mediaManager: MediaManager) {
        self.authManager = authManager
        self.mediaManager = mediaManager
        signedInUser = authManager.signedInUser
        
        downloadProfileImage()
    }
    
    func signOut() {
        authManager.signOut { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            // FIXME: After signing out, go back to sign in view
        }
    }
    
    func downloadProfileImage() {
        guard let signedInUser = signedInUser,
              let profilePhotoUrlString = signedInUser.profilePhotoUrlString,
              let profileImageUrl = URL(string: profilePhotoUrlString) else {
            return
        }

        mediaManager.downloadProfileImage(withUrl: profileImageUrl) { image, mediaError in
            if let mediaError = mediaError {
                print(mediaError.localizedDescription)
                return
            }
            
            guard let image = image else {
                return
            }

            self.profileImage = image
        }
    }
    
    
}
