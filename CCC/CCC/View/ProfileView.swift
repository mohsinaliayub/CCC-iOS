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
        VStack(alignment: .leading) {
            UserDetailsView(profileViewModel: profileViewModel)
            
            Divider()
                .padding(.top)
            
            Button("Sign Out") {
                profileViewModel.signOut()
            }
            .buttonStyle(GradientBackgroundButtonStyle())
            .padding(.top, 10)
            
            Spacer()
        }
        .padding(.top, 20)
        .padding()
    }
}

struct UserDetailsView: View {
    
    @ObservedObject var profileViewModel: ProfileViewModel
    
    var body: some View {
        HStack {
            CircularImageView(image: profileViewModel.profileImage,
                              placeholderSystemImageName: profileViewModel.profileImagePlaceholder,
                              imageHeight: 100, imageWidth: 100)
            
            VStack(alignment: .leading) {
                Text(profileViewModel.signedInUser?.fullName ?? "Full Name")
                    .font(.system(.title, design: .rounded))
                
                Text(profileViewModel.signedInUser?.email ?? "email@email.com")
                    .foregroundColor(.secondary)
                    .font(.system(.callout, design: .rounded))
            }
            .padding(.leading, 12)
            
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
