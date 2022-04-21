//
//  SignUpView.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 13.04.22.
//

import SwiftUI

private struct Constants {
    static let textFieldBorderCornerRadius: CGFloat = 10
    static let textFieldBorderLineWidth: CGFloat = 1.0
    static let textAndSecureFieldHeight: CGFloat = 30
    static let profilePhotoImageViewHeight: CGFloat = 150
    static let profilePhotoImageViewWidth: CGFloat = 150
}

struct SignUpView: View {
    
    @ObservedObject var signUpViewModel: SignUpViewModel
    @State var showPhotoOptions = false
    
    var body: some View {
        ScrollView {
            VStack {
                Text(String(localized: "Sign Up"))
                    .font(.largeTitle)
                
                VStack {
                    profileImageView
                    
                    Button("Edit") {
                        showPhotoOptions = true
                    }
                }
                .padding(.bottom)
                
                UserDataTextField(placeholder: String(localized: "First Name"),
                                    text: $signUpViewModel.firstName,
                                    keyboardType: .namePhonePad)
                UserDataTextField(placeholder: String(localized: "Last Name"),
                                    text: $signUpViewModel.lastName,
                                    keyboardType: .namePhonePad)
                UserDataTextField(placeholder: String(localized: "Email"),
                                    text: $signUpViewModel.email, keyboardType: .emailAddress)
                UserDataSecureField(placeholder: String(localized: "Password"), password: $signUpViewModel.password)
                
                signUpButton
            }
            .padding()
        }
        .fullScreenCover(isPresented: $showPhotoOptions) {
            ImagePicker(selectedImage: $signUpViewModel.profileImage)
        }
    }
    
    var profileImageView: some View {
        let image: Image
        
        if let profileImage = signUpViewModel.profileImage {
            image = Image(uiImage: profileImage)
        } else {
            image = Image(systemName: signUpViewModel.profileImagePlaceholder)
        }
        
        return image
            .resizable()
            .frame(width: Constants.profilePhotoImageViewWidth,
                   height: Constants.profilePhotoImageViewHeight)
            .scaledToFill()
            .clipShape(Circle())
            .foregroundColor(.gray)
    }
    
    var signUpButton: some View {
        AppBorderedProminentButtonWithText("Sign Up") {
            signUpViewModel.signUp()
        }
        .padding(.vertical)
    }
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(signUpViewModel: SignUpViewModel(authManager: AuthManagerImp(),
                                                    mediaManager: FirebaseMediaManager(),
                                                    userManager: FirestoreUserManager()))
    }
}
