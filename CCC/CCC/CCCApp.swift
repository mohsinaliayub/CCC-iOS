//
//  CCCApp.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 13.04.22.
//

import SwiftUI
import Firebase

@main
struct CCCApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            let authManager: AuthManager = AuthManagerImp()
            let mediaManager: MediaManager = FirebaseMediaManager()
            let userManager: UserManager = FirestoreUserManager()
            
            if authManager.signedInUser != nil {
                MainView(dashboardViewModel: DashboardViewModel(authManager: authManager,
                                                                userManager: userManager,
                                                                mediaManager: mediaManager))
            } else {
                SignInView(signInViewModel: SignInViewModel(authManager: authManager, userManager: userManager, mediaManager: mediaManager))
            }
            
        }
    }
}
