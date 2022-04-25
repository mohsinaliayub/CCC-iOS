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
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = .clear
        navBarAppearance.backgroundEffect = .none
        navBarAppearance.shadowColor = .clear
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            let authManager: AuthManager = AuthManagerImp()
            let mediaManager: MediaManager = FirebaseMediaManager()
            let userManager: UserManager = FirestoreUserManager()
            
            if authManager.signedInUser != nil {
                MainView(mainViewModel: MainViewModel(authManager: authManager, userManager: userManager, mediaManager: mediaManager))
            } else {
                SignInView(signInViewModel: SignInViewModel(authManager: authManager, userManager: userManager, mediaManager: mediaManager))
            }
            
        }
    }
}
