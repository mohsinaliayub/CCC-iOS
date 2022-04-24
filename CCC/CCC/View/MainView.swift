//
//  MainView.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 21.04.22.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var dashboardViewModel: MainViewModel
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label(String(localized: "Dashboard"), systemImage: "house")
                }
                .tag(0)
            
            StudentsView()
                .tabItem {
                    Label(String(localized: "Students"), systemImage: "list.bullet")
                }
                .tag(1)
            
            ResultsView()
                .tabItem {
                    Label(String(localized: "Results"), systemImage: "note.text")
                }
                .tag(2)
            
            ProfileView(profileViewModel: dashboardViewModel.profileViewModel)
                .tabItem {
                    Label(String(localized: "Profile"), systemImage: "person")
                }
                .tag(3)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(dashboardViewModel: MainViewModel(authManager: AuthManagerImp(),
                                                        userManager: FirestoreUserManager(),
                                                        mediaManager: FirebaseMediaManager()))
    }
}
