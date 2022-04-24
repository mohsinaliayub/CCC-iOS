//
//  BackButton.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 24.04.22.
//

import SwiftUI

struct BackButton: View {
    
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "chevron.left.circle.fill")
                .font(.largeTitle)
                .foregroundColor(.black)
        }
    }
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton(action: {  })
            .background(AppConstants.Colors.appBackgroundColor)
            
    }
}
