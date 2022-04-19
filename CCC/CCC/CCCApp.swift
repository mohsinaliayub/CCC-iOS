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
            
            SignUpView(signUpViewModel: SignUpViewModel(authManager: authManager,
                                                        mediaManager: mediaManager,
                                                        userManager: userManager))
        }
    }
}
