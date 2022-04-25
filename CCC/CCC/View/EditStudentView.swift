//
//  EditStudentView.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 25.04.22.
//

import SwiftUI

struct EditStudentView: View {
    
    @ObservedObject var viewModel = EditStudentViewModel()
    
    var body: some View {
        VStack {
            Text("Create Student")
                .font(.largeTitle)
            
            TextField("First name", text: $viewModel.firstName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Last name", text: $viewModel.lastName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Roll Number", text: $viewModel.rollNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
            TextField("CNIC", text: $viewModel.cnic)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
            TextField("Current Class", text: $viewModel.currentClass)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
            
            Button("Save") {
                viewModel.addStudentToDataStore()
            }
            .padding()
            .buttonStyle(GradientBackgroundButtonStyle())
            
            Spacer()
        }
        .padding(.top, 20)
    }
}

struct EditStudentView_Previews: PreviewProvider {
    static var previews: some View {
        EditStudentView()
    }
}
