//
//  AppButtons.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 21.04.22.
//

import SwiftUI

fileprivate struct Constants {
    static let buttonBackgroundCornerRadius: CGFloat = 10
    static let buttonInnerPadding: CGFloat = 4
    
    static let backButtonCornerRadius: CGFloat = 20
    static let backButtonWidth: CGFloat = 40
    static let backButtonHeight: CGFloat = 40
}

struct AppBorderedProminentButtonWithText: View {
    
    let text: String
    let action: () -> Void
    
    init(_ text: String, action: @escaping () -> Void) {
        self.text = text
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .font(.system(.title2, design: .rounded))
                .frame(maxWidth: .infinity)
                .padding(Constants.buttonInnerPadding)
        }
        .buttonStyle(.borderedProminent)
        .cornerRadius(Constants.buttonBackgroundCornerRadius)
        .controlSize(.large)
    }
}

struct GradientBackgroundButtonStyle: ButtonStyle {
    
    var colors: [Color] = [Color(red: 251/255, green: 128/255, blue: 128/255),
                           Color(red: 253/255, green: 193/255, blue: 104/255)]
    var startPoint = UnitPoint.leading
    var endPoint = UnitPoint.trailing
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .font(.system(.title2, design: .rounded))
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(colors: colors, startPoint: startPoint, endPoint: endPoint))
            .controlSize(.large)
            .cornerRadius(Constants.buttonBackgroundCornerRadius)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

struct BackButton: View {
    
    var action: () -> Void
    
    var systemIconName = "chevron.left"
    var backgroundColor: Color = .white
    var foregroundColor: Color = .black
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: systemIconName)
                .font(.title)
                .foregroundColor(foregroundColor)
                .frame(width: Constants.backButtonHeight, height: Constants.backButtonHeight)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: Constants.backButtonCornerRadius))
        }
    }
}

struct AppButtons_Previews: PreviewProvider {
    static var previews: some View {
        AppBorderedProminentButtonWithText("Sign Up", action: {  })
            .previewLayout(.sizeThatFits)
        
        Button("Sign In", action: {})
            .buttonStyle(GradientBackgroundButtonStyle())
            .previewLayout(.sizeThatFits)
    }
}
