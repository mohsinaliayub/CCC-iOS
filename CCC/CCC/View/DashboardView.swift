//
//  DashboardView.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 21.04.22.
//

import SwiftUI

struct DashboardView: View {
    
    @ObservedObject var dashboardViewModel: DashboardViewModel
    
    var body: some View {
        Text("Hello, World!")
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(dashboardViewModel: DashboardViewModel(authManager: AuthManagerImp(),
                                                             userManager: FirestoreUserManager()))
    }
}
