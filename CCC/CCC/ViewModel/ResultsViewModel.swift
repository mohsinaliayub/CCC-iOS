//
//  ResultsViewModel.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 25.04.22.
//

import Foundation

class ResultsViewModel: ObservableObject {
    
    @Published var results: [SubjectResult] = []
    
    private let student: Student
    private let resultsManager: ResultsManager
    
    init(student: Student, resultsManager: ResultsManager) {
        self.resultsManager = resultsManager
        self.student = student
    }
    
}
