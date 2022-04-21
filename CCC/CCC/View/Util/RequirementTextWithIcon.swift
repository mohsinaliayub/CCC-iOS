//
//  RequirementTextWithIcon.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 21.04.22.
//

import SwiftUI

fileprivate struct Constants {
    static let errorColor = Color(red: 251/255, green: 128/255, blue: 128/255)
    static let iconColor = Color(red: 1/255, green: 251/255, blue: 128/255)
}

struct RequirementTextWithIcon: View {
    var iconName = "xmark.square"
    var iconColor = IconColor.errorColor
    
    var text = ""
    var isStrikeThrough = false
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(iconColor.color)
            Text(text)
                .font(.system(.body, design: .rounded))
                .foregroundColor(.secondary)
                .strikethrough(iconColor == .successColor)
            Spacer()
        }
    }
    
    enum IconColor {
        case errorColor
        case successColor
        
        var color: Color {
            switch self {
            case .errorColor: return Constants.errorColor
            case .successColor: return Constants.iconColor
            }
        }
    }
}

struct Requirement_Previews: PreviewProvider {
    static var previews: some View {
        RequirementTextWithIcon(text: "A minimum of 8 characters")
            .previewLayout(.sizeThatFits)
        
        RequirementTextWithIcon(iconColor: .successColor, text: "A minimum of 8 characters")
            .previewLayout(.sizeThatFits)
    }
}
