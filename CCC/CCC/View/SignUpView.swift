//
//  SignUpView.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 13.04.22.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject var signUpViewModel: SignUpViewModel
    
    var body: some View {
        VStack {
            Text(String(localized: "Sign Up"))
                .font(.largeTitle)
            
            emailField
            passwordField
            signUpButton
        }
        .padding()
    }
    
    var signUpButton: some View {
        Button {
            signUpViewModel.signUp()
        } label: {
            Text(String(localized: "Sign Up"))
                .font(.system(.title2, design: .rounded))
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.roundedRectangle(radius: Constants.textFieldBorderCornerRadius))
        .controlSize(.large)
        .padding(.vertical)
    }
    
    var emailField: some View {
        TextField(String(localized: "Email"), text: $signUpViewModel.email)
            .frame(height: Constants.textAndSecureFieldHeight)
            .padding()
            .overlay {
                roundedRectangle
            }
            .keyboardType(.emailAddress)
    }
    
    var passwordField: some View {
        SecureField(String(localized: "Password"), text: $signUpViewModel.password)
            .frame(height: Constants.textAndSecureFieldHeight)
            .padding()
            .overlay {
                roundedRectangle
            }
    }
    
    var roundedRectangle: some View {
        RoundedRectangleWithBorderAndLineWidth(cornerRadius: Constants.textFieldBorderCornerRadius,
                                               lineWidth: Constants.textFieldBorderLineWidth)
    }
    
    private struct Constants {
        static let textFieldBorderCornerRadius: CGFloat = 10
        static let textFieldBorderLineWidth: CGFloat = 1.0
        static let textAndSecureFieldHeight: CGFloat = 30
    }
}

fileprivate struct RoundedRectangleWithBorderAndLineWidth: View {
    
    let cornerRadius: CGFloat
    let lineWidth: CGFloat
    let color: Color = .gray
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .strokeBorder(color, lineWidth: lineWidth)
    }
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(signUpViewModel: SignUpViewModel(authManager: AuthManagerImp()))
    }
}
