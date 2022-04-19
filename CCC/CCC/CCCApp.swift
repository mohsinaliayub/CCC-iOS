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
            SignUpView(signUpViewModel: SignUpViewModel(authManager: AuthManagerImp()))
        }
    }
}
