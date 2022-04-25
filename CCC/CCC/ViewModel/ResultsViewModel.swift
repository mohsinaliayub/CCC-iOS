//
//  ResultsViewModel.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 25.04.22.
//

import Foundation

class ResultsViewModel: ObservableObject {
    
    @Published var results: [StudentResult] = []
    private var lastResultTimeStamp: Int?
    private let resultsLimit: UInt = 10
    
    var testStudentResult: StudentResult {
        var dateComponents = DateComponents()
        dateComponents.year = 2011
        dateComponents.month = 9
        dateComponents.day = 27
        let date = Calendar.current.date(from: dateComponents)!
        
        let math = SubjectResult(subjectName: "Mathematics", totalMarks: 40, obtainedMarks: 40)
        let physics = SubjectResult(subjectName: "Physics", totalMarks: 40, obtainedMarks: 40)
        let chemistry = SubjectResult(subjectName: "Chemistry", totalMarks: 40, obtainedMarks: 32)
        let urdu = SubjectResult(subjectName: "Urdu", totalMarks: 40, obtainedMarks: 34)
        let english = SubjectResult(subjectName: "English", totalMarks: 40, obtainedMarks: 38)
        let pakSt = SubjectResult(subjectName: "Pak Studies", totalMarks: 40, obtainedMarks: 37)
        
        let subjectResults = [math, physics, chemistry, urdu, english, pakSt]
        let result = StudentResult(studentId: student.id, studentClass: student.currentClass, positionInClass: 1,
                                   termName: "September Term", timestamp: date, remarks: "1st position", passed: true, subjectResults: subjectResults)
        
        return result
    }
    
    private let student: Student
    private let resultsManager: ResultsManager
    
    init(student: Student, resultsManager: ResultsManager) {
        self.resultsManager = resultsManager
        self.student = student
        
        if results.isEmpty {
            fetchResults()
        }
    }
    
    func fetchResults() {
        resultsManager.fetchResults(for: student.id, withStartTimestamp: lastResultTimeStamp, andLimit: resultsLimit) { results, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            // Sort the results by latest
            let sortedResults = results.sorted { $0.timestamp > $1.timestamp }
            
            // Save the last result's timestamp to retrieve new items
            if let lastResult = sortedResults.last {
                let timestamp = Int(lastResult.timestamp.timeIntervalSince1970)
                self.lastResultTimeStamp = timestamp
            }
            self.results = sortedResults
        }
    }
    
    func addTestResults() {
        resultsManager.addResult(testStudentResult) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            print("Result posted successfully!")
        }
    }
    
}
