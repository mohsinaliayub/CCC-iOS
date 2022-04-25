//
//  StudentsManager.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 25.04.22.
//

import Foundation
import FirebaseDatabase

typealias ParentId = String

protocol StudentsManager {
    func addStudent(_ student: Student, for parent: ParentId, completion: @escaping (Error?) -> Void)
    func fetchStudents(for parent: ParentId, completion: @escaping ([Student], Error?) -> Void)
}

class FirebaseDbStudentManager: StudentsManager {
    
    private let childKey = "students"
    private var databaseReference: DatabaseReference {
        Database.database().reference().child(childKey)
    }
    
    func addStudent(_ student: Student, for parent: ParentId, completion: @escaping (Error?) -> Void) {
        let addStudentDatabaseRef = databaseReference.childByAutoId()
        
        addStudentDatabaseRef.setValue(student.dictionary) { error, dbReference in
            completion(error)
        }
    }
    
    func fetchStudents(for parent: ParentId, completion: @escaping ([Student], Error?) -> Void) {
        let fetchStudentsDbRef = databaseReference.queryOrdered(byChild: Student.Key.parentId).queryEqual(toValue: parent)
        
        fetchStudentsDbRef.observeSingleEvent(of: .value) { snapshot in
            var students = [Student]()
            
            for item in snapshot.children.allObjects as! [DataSnapshot] {
                let studentDict = item.value as! [String: Any]
                
                let student = Student(from: studentDict)
                students.append(student)
            }
            
            completion(students, nil)
        }
    }
    
}
