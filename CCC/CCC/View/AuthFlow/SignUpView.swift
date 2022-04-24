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
    
    private enum Form {
        case firstName
        case lastName
        case email
        case password
        case signUp
    }
    
    @ObservedObject var signUpViewModel: SignUpViewModel
    @State var showPhotoOptions = false
    @Environment(\.dismiss) private var dismiss
    
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
                
                FormFields(signUpViewModel: signUpViewModel)
                signUpButton
            }
            .padding()
        }
        .fullScreenCover(isPresented: $showPhotoOptions) {
            ImagePicker(selectedImage: $signUpViewModel.profileImage)
        }
        .navigationBarBackButtonHidden(true)
        .background(AppConstants.Colors.appBackgroundColor)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton {
                    dismiss()
                }
            }
        })
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
        Button(String(localized: "Join now"), action: {
            signUpViewModel.signUp()
        })
        .padding(.vertical)
        .buttonStyle(GradientBackgroundButtonStyle())
    }
    
}

private struct FormFields: View {
    
    @ObservedObject var signUpViewModel: SignUpViewModel
    @FocusState private var focused: SignUpViewModel.Form?
    
    var body: some View {
        VStack {
            UserDataTextField(placeholder: String(localized: "First Name"),
                              text: $signUpViewModel.firstName,
                              keyboardType: .namePhonePad)
            .focused($focused, equals: .firstName)
            .submitLabel(.next)
            
            UserDataTextField(placeholder: String(localized: "Last Name"),
                              text: $signUpViewModel.lastName,
                              keyboardType: .namePhonePad)
            .focused($focused, equals: .lastName)
            .submitLabel(.next)
            
            UserDataTextField(placeholder: String(localized: "Email"),
                              text: $signUpViewModel.email, keyboardType: .emailAddress)
            .focused($focused, equals: .email)
            .submitLabel(.next)
            
            UserDataSecureField(placeholder: String(localized: "Password"),
                                password: $signUpViewModel.password)
            .focused($focused, equals: .password)
            .submitLabel(.join)
        }
        .onSubmit {
            signUpViewModel.submit(form: &focused)
        }
    }
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(signUpViewModel: SignUpViewModel(authManager: AuthManagerImp(),
                                                    mediaManager: FirebaseMediaManager(),
                                                    userManager: FirestoreUserManager()))
    }
}
