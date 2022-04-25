//
//  EditStudentViewModel.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 25.04.22.
//

import Foundation

class EditStudentViewModel: ObservableObject {
    
    @Published var firstName: String
    @Published var lastName: String
    @Published var rollNumber: String
    @Published var cnic: String
    @Published var currentClass: String
    
    private let authManager: AuthManager
    private let studentsManager: StudentsManager
    
    init() {
        firstName = ""; lastName = ""; rollNumber = "";
        cnic = ""; currentClass = ""
        
        authManager = AuthManagerImp()
        studentsManager = FirebaseDbStudentManager()
    }
    
    func addStudentToDataStore() {
        guard let currentUser = authManager.signedInUser else { return }
        
        let student = Student(parentId: currentUser.id, firstName: firstName, lastName: lastName,
                              rollNumber: rollNumber, cnic: cnic, photoUrlString: currentUser.profilePhotoUrlString ?? "",
                              currentClass: currentClass)
        
        studentsManager.addStudent(student, for: currentUser.id) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            print("Success!")
        }
    }
    
}
