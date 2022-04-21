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
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField(placeholder, text: $text)
                .frame(height: Constants.textAndSecureFieldHeight)
                .padding()
                .keyboardType(keyboardType)
                .overlay {
                    RoundedRectangleWithBorderAndLineWidth(cornerRadius: Constants.textFieldBorderCornerRadius,
                                                           lineWidth: Constants.textFieldBorderLineWidth)
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
    
    var body: some View {
        SecureField(placeholder, text: $password)
            .frame(height: Constants.textAndSecureFieldHeight)
            .padding()
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

struct UserDataEntryFields_Previews: PreviewProvider {
    static var previews: some View {
        UserDataTextField(placeholder: "Email", text: .constant(""), keyboardType: .emailAddress, isValid: false, invalidText: "Please provide a valid email address.")
            .previewLayout(.sizeThatFits)
        UserDataSecureField(placeholder: "Password", password: .constant(""))
            .previewLayout(.sizeThatFits)
    }
}
