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
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            if segment == 0 {
                StudentInfoView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if segment == 1 {
                ResultsView(resultsViewModel: studentDetailViewModel.resultsViewModel)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                Spacer()
            }
        }
        .background(AppConstants.Colors.appBackgroundColor)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton { dismiss() }
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
        let studentDetailVM = StudentDetailViewModel(student: Student(from: [:]),
                                                     resultsManager: FirebaseDbResultsManager())
        StudentDetailView(studentDetailViewModel: studentDetailVM)
    }
}
