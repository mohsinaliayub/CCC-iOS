//
//  StudentResult.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 25.04.22.
//

import Foundation

struct StudentResult {
    let id: String
    let studentId: String
    let studentClass: String
    let positionInClass: Int
    let termName: String
    let timestamp: Date
    let remarks: String
    let passed: Bool
    let subjectResults: [SubjectResult]
    
    var totalMarks: Int { subjectResults.reduce(0) { $0 + $1.totalMarks } }
    var obtainedMarks: Int { subjectResults.reduce(0) { $0 + $1.obtainedMarks } }
    
    init(studentId: String, studentClass: String, positionInClass: Int, termName: String,
         timestamp: Date, remarks: String, passed: Bool, subjectResults: [SubjectResult]) {
        self.id = UUID().uuidString
        self.studentId = studentId
        self.studentClass = studentClass
        self.positionInClass = positionInClass
        self.termName = termName
        self.timestamp = timestamp
        self.remarks = remarks
        self.passed = passed
        self.subjectResults = subjectResults
    }
    
    var dictionary: [String: Any] {
        [
            Key.id: id,
            Key.studentId: studentId,
            Key.studentClass: studentClass,
            Key.positionInClass: positionInClass,
            Key.termName: termName,
            Key.timestamp: timestamp.timeIntervalSince1970,
            Key.remarks: remarks,
            Key.passed: passed,
            Key.subjectResults: subjectResults.map { $0.dictionary }
        ]
    }
    
    struct Key {
        static let id = "id"
        static let studentId = "student_id"
        static let studentClass = "student_class"
        static let positionInClass = "position"
        static let termName = "term_name"
        static let timestamp = "timestamp"
        static let remarks = "remarks"
        static let passed = "passed"
        static let subjectResults = "subject_results"
    }
}

extension StudentResult {
    
    init(from dictionary: [String: Any]) {
        self.id = dictionary[Key.id] as! String
        self.studentId = dictionary[Key.id] as! String
        self.studentClass = dictionary[Key.studentClass] as! String
        self.positionInClass = dictionary[Key.positionInClass] as! Int
        self.termName = dictionary[Key.termName] as! String
        self.timestamp = Date(timeIntervalSince1970: TimeInterval(dictionary[Key.timestamp] as! Int))
        self.remarks = dictionary[Key.remarks] as! String
        self.passed = dictionary[Key.passed] as! Bool
        var subjectResults = [SubjectResult]()
        let subjectResultsDict = dictionary[Key.subjectResults] as! [[String: Any]]
        for result in subjectResultsDict {
            subjectResults.append(SubjectResult(from: result))
        }
        self.subjectResults = subjectResults
    }
    
}

struct SubjectResult: Identifiable {
    let subjectName: String
    let totalMarks: Int
    let obtainedMarks: Int
    
    var id: UUID { UUID() }
    
    var dictionary: [String: Any] {
        [
            Key.subjectName: subjectName,
            Key.totalMarks: totalMarks,
            Key.obtainedMarks: obtainedMarks
        ]
    }
    
    init(subjectName: String, totalMarks: Int, obtainedMarks: Int) {
        self.subjectName = subjectName
        self.totalMarks = totalMarks
        self.obtainedMarks = obtainedMarks
    }
    
    init(from dictionary: [String: Any]) {
        subjectName = dictionary[Key.subjectName] as! String
        totalMarks = dictionary[Key.totalMarks] as! Int
        obtainedMarks = dictionary[Key.obtainedMarks] as! Int
    }
    
    struct Key {
        static let subjectName = "subject_name"
        static let totalMarks = "total_marks"
        static let obtainedMarks = "obtained_marks"
    }
}
