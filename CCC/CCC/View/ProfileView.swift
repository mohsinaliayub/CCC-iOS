//
//  ProfileView.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 21.04.22.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var profileViewModel: ProfileViewModel
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    UserDetailsView(profileViewModel: profileViewModel)
                        .padding(.vertical)
                }
                
                Section {
                    InfoItem(text: String(localized: "About"), systemIcon: "info.circle.fill")
                    InfoItem(text: String(localized: "Contact Us"), systemIcon: "bubble.left.fill")
                }
                
                Section {
                    Button("Sign Out") {
                        profileViewModel.signOut()
                    }
                    .buttonStyle(GradientBackgroundButtonStyle())
                    .padding(.horizontal, -20)
                    .padding(.vertical, -8)
                }
                
            }
            .listSectionSeparator(.hidden)
            .listStyle(.grouped)
            .navigationTitle(String(localized: "Profile"))
        }
        .font(.title3)
    }
}

struct InfoItem: View {
    
    let text: String
    let systemIcon: String
    
    var body: some View {
        HStack {
            Image(systemName: systemIcon)
                .frame(width: 40, height: 40)
            Text(text)
        }
        .font(.title2)
    }
}

struct UserDetailsView: View {
    
    @ObservedObject var profileViewModel: ProfileViewModel
    
    var body: some View {
        HStack {
            CircularImageView(image: profileViewModel.profileImage,
                              placeholderSystemImageName: profileViewModel.profileImagePlaceholder,
                              imageHeight: 90, imageWidth: 90)
            
            VStack(alignment: .leading) {
                Text(profileViewModel.signedInUser?.fullName ?? "Full Name")
                    .font(.system(.title, design: .rounded))
                
                Text(profileViewModel.signedInUser?.email ?? "email@email.com")
                    .foregroundColor(.secondary)
                    .font(.system(.title3, design: .rounded))
            }
            .padding(.all, 12)
            
            Spacer()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(profileViewModel: ProfileViewModel(authManager: AuthManagerImp(),
                                                       mediaManager: FirebaseMediaManager()))
    }
}
