//
//  UserDataEntryFields.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 21.04.22.
//

import SwiftUI

fileprivate struct Constants {
    static let textFieldBorderCornerRadius: CGFloat = 10
    static let textFieldBorderLineWidth: CGFloat = 1.0
    static let textAndSecureFieldHeight: CGFloat = 30
}

struct UserDataTextField: View {
    
    let placeholder: String
    @Binding var text: String
    let keyboardType: UIKeyboardType
    
    var isValid = true
    var invalidText = ""
    
    @FocusState var focused: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField(placeholder, text: $text)
                .frame(height: Constants.textAndSecureFieldHeight)
                .padding()
                .keyboardType(keyboardType)
                .textInputAutocapitalization(keyboardType == .emailAddress ? .never : nil)
                .focused($focused)
                .overlay {
                    RoundedRectangleWithBorderAndLineWidth(cornerRadius: Constants.textFieldBorderCornerRadius,
                                                           lineWidth: Constants.textFieldBorderLineWidth)
                    .onTapGesture {
                        focused = true
                    }
                }
            
            if !isValid && !text.isEmpty {
                Text(invalidText)
                    .font(.caption)
                    .foregroundColor(.red)
                    .padding(.leading)
            }
        }
    }
    
}

struct UserDataSecureField: View {
    
    let placeholder: String
    @Binding var password: String
    @FocusState var focused: Bool
    
    var body: some View {
        SecureField(placeholder, text: $password)
            .frame(height: Constants.textAndSecureFieldHeight)
            .padding()
            .focused($focused)
            .overlay {
                RoundedRectangleWithBorderAndLineWidth(cornerRadius: Constants.textFieldBorderCornerRadius,
                                                       lineWidth: Constants.textFieldBorderLineWidth)
                .onTapGesture {
                    focused = true
                }
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

struct UserDataEntryFields_Previews: PreviewProvider {
    static var previews: some View {
        UserDataTextField(placeholder: "Email", text: .constant(""), keyboardType: .emailAddress, isValid: false, invalidText: "Please provide a valid email address.")
            
        UserDataSecureField(placeholder: "Password", password: .constant(""))
            .previewLayout(.sizeThatFits)
    }
}
