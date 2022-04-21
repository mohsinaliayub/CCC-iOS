//
//  SignInViewModel.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 21.04.22.
//

import Foundation
import Combine

class SignInViewModel: ObservableObject {
    
    @Published var email: String
    @Published var password: String
    @Published var isEmailValid = false
    @Published var isPasswordValid = false
    @Published var signInError: SignInError?
    
    private let authManager: AuthManager
    private let userManager: UserManager
    private var cancellable = Set<AnyCancellable>()
    private var isInputValid: Bool {
        isEmailValid && isPasswordValid
    }
    
    init(authManager: AuthManager, userManager: UserManager) {
        email = ""; password = ""
        self.authManager = authManager
        self.userManager = userManager
        
        setupSubscriptionChainForValidation()
    }
    
    func signIn() {
        guard isInputValid else { return }
        
        authManager.signIn(withEmail: email, password: password) { userId, error in
            if let error = error {
                self.signInError = error
                return
            }
            
            guard let userId = userId else {
                return
            }

            // We have the userId, get user account details.
            print(userId)
        }
    }
    
    func setupSubscriptionChainForValidation() {
        $email
            .receive(on: RunLoop.main)
            .map { email in
                EmailValidator.validate(with: email)
            }
            .assign(to: \.isEmailValid, on: self)
            .store(in: &cancellable)
        
        $password
            .receive(on: RunLoop.main)
            .map { password in
                PasswordValidator.validate(password)
            }
            .assign(to: \.isPasswordValid, on: self)
            .store(in: &cancellable)
    }
    
}
