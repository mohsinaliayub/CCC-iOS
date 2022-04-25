//
//  StudentsView.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 21.04.22.
//

import SwiftUI

struct StudentsView: View {
    
    @ObservedObject var studentsViewModel: StudentsViewModel
    
    var body: some View {
        List(studentsViewModel.students, id: \.id) { student in
            StudentBasicInfoView(student: student, studentsViewModel: studentsViewModel)
        }
        .task {
            studentsViewModel.fetchStudents()
        }
        .navigationTitle("Students")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: EditStudentView()) {
                    Label("Add", systemImage: "plus")
                        .font(.title2)
                }
            }
        }
    }
}

struct StudentBasicInfoView: View {
    
    let student: Student
    var studentsViewModel: StudentsViewModel
    @State private var image: UIImage?
    
    var body: some View {
        HStack {
            CircularImageView(image: image, placeholderSystemImageName: "person.crop.circle",
                              imageHeight: 90, imageWidth: 90)
            .task {
                studentsViewModel.downloadImage(with: student.photoUrlString) { image in
                    self.image = image
                }
            }
            
            VStack(alignment: .leading) {
                Text(student.fullName)
                    .font(.title)
                
                HStack {
                    Text("Class:")
                        .fontWeight(.semibold)
                    Text(student.currentClass)
                }
                
                HStack {
                    Text("Roll number:")
                        .fontWeight(.bold)
                    Text(student.rollNumber)
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .contentShape(Rectangle())
    }
}

struct StudentsView_Previews: PreviewProvider {
    static var previews: some View {
        let studentsVM = StudentsViewModel(authManager: AuthManagerImp(), studentsManager: FirebaseDbStudentManager(), mediaManager: FirebaseMediaManager())
        NavigationView {
            StudentsView(studentsViewModel: studentsVM)
        }
        
        let student = Student(parentId: "", firstName: "John", lastName: "Doe", rollNumber: "1636", cnic: "3720148895404", photoUrlString: "", currentClass: "12")
        
        StudentBasicInfoView(student: student, studentsViewModel: studentsVM)
    }
}
