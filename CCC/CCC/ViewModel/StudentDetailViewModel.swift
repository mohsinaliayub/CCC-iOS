//
//  StudentDetailViewModel.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 25.04.22.
//

import Foundation

class StudentDetailViewModel: ObservableObject {
    
    private let student: Student
    private let resultsManager: ResultsManager
    
    var resultsViewModel: ResultsViewModel {
        ResultsViewModel(student: student, resultsManager: resultsManager)
    }
    
    init(student: Student, resultsManager: ResultsManager) {
        self.student = student
        self.resultsManager = resultsManager
    }
    
}
