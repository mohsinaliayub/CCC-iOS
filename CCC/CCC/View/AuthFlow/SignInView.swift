//
//  SignInView.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 21.04.22.
//

import SwiftUI

struct SignInView: View {
    
    @ObservedObject var signInViewModel: SignInViewModel
    @FocusState private var focused: SignInViewModel.Form?
    
    var body: some View {
        NavigationView {
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
                    .focused($focused, equals: .email)
                    .submitLabel(.next)
                    
                    UserDataSecureField(placeholder: String(localized: "Password"),
                                        password: $signInViewModel.password)
                    .focused($focused, equals: .password)
                    .submitLabel(.continue)
                    
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
                
                HStack {
                    Text(String(localized: "Forgot your password?"))
                        .font(.system(.body, design: .rounded))
                        .fontWeight(.bold)
                    
                    Button("Reset now") {
                        
                    }
                }
                
                Spacer()
                
                HStack {
                    Text(String(localized: "Don't have a user account?"))
                        .font(.system(.body, design: .rounded))
                        .fontWeight(.bold)
                    
                    NavigationLink(destination: SignUpView(signUpViewModel: signInViewModel.signUpViewModel)) {
                        Text(String(localized: "Create new"))
                            .foregroundColor(.accentColor)
                    }
                }
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .background(AppConstants.Colors.appBackgroundColor)
            
        }
        .fullScreenCover(isPresented: $signInViewModel.signInSuccessful) {
            MainView(mainViewModel: signInViewModel.dashboardViewModel)
        }
        .onSubmit {
            signInViewModel.submit(form: &focused)
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(signInViewModel: SignInViewModel(authManager: AuthManagerImp(),
                                                    userManager: FirestoreUserManager(),
                                                    mediaManager: FirebaseMediaManager()))
    }
}
