//
//  SignInView.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 21.04.22.
//

import SwiftUI

struct SignInView: View {
    
    @ObservedObject var signInViewModel: SignInViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                Text(String(localized: "Sign In"))
                    .font(.system(.largeTitle, design: .rounded))
                    .padding(.top)
                
                VStack(alignment: .leading) {
                    UserDataTextField(placeholder: String(localized: "Email"),
                                      text: $signInViewModel.email,
                                      keyboardType: .emailAddress,
                                      isValid: signInViewModel.isEmailValid,
                                      invalidText: "Please provide a valid email address.")
                    
                    UserDataSecureField(placeholder: String(localized: "Password"),
                                        password: $signInViewModel.password)
                    
                    if let signInError = signInViewModel.signInError {
                        Text(signInError.description)
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding(.vertical, 4)
                    }
                }
                
                Button("Sign In") {
                    signInViewModel.signIn()
                }
                .padding(.vertical)
                .buttonStyle(GradientBackgroundButtonStyle())
            }
            .padding()
        }
        .fullScreenCover(isPresented: $signInViewModel.signInSuccessful) {
            DashboardView(dashboardViewModel: signInViewModel.dashboardViewModel)
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(signInViewModel: SignInViewModel(authManager: AuthManagerImp(),
                                                    userManager: FirestoreUserManager()))
    }
}
