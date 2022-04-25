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
    let subjectResults: [SubjectResult]
    
    var totalMarks: Int { subjectResults.reduce(0) { $0 + $1.totalMarks } }
    var obtainedMarks: Int { subjectResults.reduce(0) { $0 + $1.obtainedMarks } }
    
    var dictionary: [String: Any] {
        [
            Key.id: id,
            Key.studentId: studentId,
            Key.studentClass: studentClass,
            Key.positionInClass: positionInClass,
            Key.termName: termName,
            Key.timestamp: timestamp.timeIntervalSince1970,
            Key.remarks: remarks,
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
        var subjectResults = [SubjectResult]()
        let subjectResultsDict = dictionary[Key.subjectResults] as! [[String: Any]]
        for result in subjectResultsDict {
            subjectResults.append(SubjectResult(from: result))
        }
        self.subjectResults = subjectResults
    }
    
}

struct SubjectResult {
    let subjectName: String
    let totalMarks: Int
    let obtainedMarks: Int
    
    var dictionary: [String: Any] {
        [
            Key.subjectName: subjectName,
            Key.totalMarks: totalMarks,
            Key.obtainedMarks: obtainedMarks
        ]
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
