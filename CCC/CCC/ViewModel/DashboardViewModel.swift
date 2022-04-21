//
//  DashboardViewModel.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 21.04.22.
//

import Foundation

class DashboardViewModel: ObservableObject {
    
    private let signedInUserKey = "signedInUser"
    var signedInUser: User? {
        get { authManager.signedInUser }
        set { authManager.signedInUser = newValue }
    }
    
    private let userManager: UserManager
    private let authManager: AuthManager
    
    init(authManager: AuthManager, userManager: UserManager) {
        self.authManager = authManager
        self.userManager = userManager
        
        fetchSignedInUserDetailsFromFirestore()
    }
    
    func fetchSignedInUserDetailsFromFirestore() {
        guard let signedInUserId = authManager.signedInUserId, authManager.signedInUser == nil else {
            // FIXME: If no user is signed in, show SignInView screen.
            return
        }
        
        userManager.fetchUser(byId: signedInUserId) { user, error in
            guard let user = user, error == nil else {
                print(error!.rawValue)
                return
            }

            self.signedInUser = user
        }
    }
    
}
