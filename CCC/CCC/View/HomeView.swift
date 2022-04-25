//
//  HomeView.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 21.04.22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Text("Home View")
                .font(.system(.largeTitle, design: .rounded))
            
            BackButton {
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppConstants.Colors.appBackgroundColor)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
