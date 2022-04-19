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
                
                SignUpViewTextField(placeholder: String(localized: "First Name"),
                                    text: $signUpViewModel.firstName,
                                    keyboardType: .namePhonePad)
                SignUpViewTextField(placeholder: String(localized: "Last Name"),
                                    text: $signUpViewModel.lastName,
                                    keyboardType: .namePhonePad)
                SignUpViewTextField(placeholder: String(localized: "Email"),
                                    text: $signUpViewModel.email, keyboardType: .emailAddress)
                passwordField
                
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
    
}

struct SignUpViewTextField: View {
    
    let placeholder: String
    var text: Binding<String>
    let keyboardType: UIKeyboardType
    
    var body: some View {
        TextField(placeholder, text: text)
            .frame(height: Constants.textAndSecureFieldHeight)
            .padding()
            .keyboardType(keyboardType)
            .overlay {
                RoundedRectangleWithBorderAndLineWidth(cornerRadius: Constants.textFieldBorderCornerRadius,
                                                       lineWidth: Constants.textFieldBorderLineWidth)
            }
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
