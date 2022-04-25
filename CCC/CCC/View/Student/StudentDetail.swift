//
//  StudentDetail.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 25.04.22.
//

import SwiftUI

struct StudentDetailView: View {
    
    @ObservedObject var studentDetailViewModel: StudentDetailViewModel
    @Environment(\.dismiss) private var dismiss
    @State var segment = 0
    
    var body: some View {
        VStack {
            Picker("", selection: $segment) {
                Text("Detail").tag(0)
                Text("Results").tag(1)
            }
            .background(AppConstants.Colors.appBackgroundColor)
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            if segment == 0 {
                StudentInfoView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(AppConstants.Colors.appBackgroundColor)
            } else if segment == 1 {
                ResultsView(resultsViewModel: studentDetailViewModel.resultsViewModel)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(AppConstants.Colors.appBackgroundColor)
            } else {
                Spacer()
            }
        }
        .background(AppConstants.Colors.appBackgroundColor)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Label("", systemImage: "chevron.left")
                }
            }
        }
    }
}

struct StudentInfoView: View {
    
    var body: some View {
        Text("Student Info")
            .font(.largeTitle)
    }
}

struct StudentDetail_Previews: PreviewProvider {
    static var previews: some View {
        let student = Student(parentId: "", firstName: "John", lastName: "Doe", rollNumber: "1636", cnic: "3720148895404", photoUrlString: "", currentClass: "12")
        let studentDetailVM = StudentDetailViewModel(student: student,
                                                     resultsManager: FirebaseDbResultsManager())
        StudentDetailView(studentDetailViewModel: studentDetailVM)
    }
}
