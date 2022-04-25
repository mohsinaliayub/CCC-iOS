//
//  MainView.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 21.04.22.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var mainViewModel: MainViewModel
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label(String(localized: "Dashboard"), systemImage: "house")
                }
                .tag(0)
            
            NavigationView {
                StudentsView(studentsViewModel: mainViewModel.studentsViewModel)
            }
            .tabItem {
                Label(String(localized: "Students"), systemImage: "list.bullet")
            }
            .tag(1)
            
            ProfileView(profileViewModel: mainViewModel.profileViewModel)
                .tabItem {
                    Label(String(localized: "Profile"), systemImage: "person")
                }
                .tag(3)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(mainViewModel: MainViewModel(authManager: AuthManagerImp(),
                                              userManager: FirestoreUserManager(),
                                              mediaManager: FirebaseMediaManager()))
    }
}
