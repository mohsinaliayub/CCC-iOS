//
//  ResetPasswordView.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 21.04.22.
//

import SwiftUI

struct ResetPasswordView: View {
    
    var body: some View {
        VStack {
            Text("Forgot Your Password")
                .font(.system(.largeTitle, design: .rounded))
            
            UserDataTextField(placeholder: "Enter your email", text: .constant(""),
                              keyboardType: .emailAddress)
            AppBorderedProminentButtonWithText("Send Verification Email") {
                
            }
            .padding(.top, 10)
            
            Text("Verification email has been sent. Please check your inbox.")
                .font(.caption)
                .foregroundColor(.red)
                .hidden()
            
            Spacer()
        }
        .padding()
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
