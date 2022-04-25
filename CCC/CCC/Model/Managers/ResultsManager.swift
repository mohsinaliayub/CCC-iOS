//
//  ResultsManager.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 25.04.22.
//

import Foundation
import FirebaseDatabase

typealias StudentId = String

protocol ResultsManager {
    func addResult(_: StudentResult, completion: @escaping (Error?) -> Void)
    func fetchResults(for: StudentId, withStartTimestamp: Int?, andLimit: UInt, completion: @escaping ([StudentResult], Error?) -> Void)
}

class FirebaseDbResultsManager: ResultsManager {
    
    private let childKey = "Results"
    private var databaseReference: DatabaseReference {
        Database.database().reference().child(childKey)
    }
    
    private var resultsToFetchCount = 10
    
    func addResult(_ studentResult: StudentResult, completion: @escaping (Error?) -> Void) {
        let addResultDbRef = databaseReference.childByAutoId()
        
        addResultDbRef.setValue(studentResult.dictionary) { error, _ in
            completion(error)
        }
    }
    
    func fetchResults(for studentId: StudentId, withStartTimestamp startTimestamp: Int?, andLimit limit: UInt,
                      completion: @escaping ([StudentResult], Error?) -> Void) {
        let fetchResultsDbRef: DatabaseQuery
        if let timestamp = startTimestamp {
            fetchResultsDbRef = databaseQuery(withTimestamp: timestamp, studentId: studentId, and: limit)
        } else {
            fetchResultsDbRef = databaseQuery(with: studentId, and: limit)
        }
        
        fetchResultsDbRef.observeSingleEvent(of: .value) { snapshot in
            var results = [StudentResult]()
            
            for item in snapshot.children.allObjects as! [DataSnapshot] {
                guard let resultDict = item.value as? [String: Any] else { continue }
                
                let result = StudentResult(from: resultDict)
                results.append(result)
            }
            
            completion(results, nil)
        }
    }
    
    private func databaseQuery(withTimestamp timestamp: Int, studentId: StudentId, and limit: UInt) -> DatabaseQuery {
        databaseReference
            .queryOrdered(byChild: StudentResult.Key.studentId)
            .queryEqual(toValue: studentId)
//            .queryOrdered(byChild: StudentResult.Key.timestamp)
//            .queryEqual(toValue: timestamp - 1)
            .queryLimited(toLast: limit)
    }
    
    private func databaseQuery(with studentId: StudentId, and limit: UInt) -> DatabaseQuery {
        databaseReference
            .queryOrdered(byChild: StudentResult.Key.studentId)
            .queryEqual(toValue: studentId)
//            .queryOrdered(byChild: StudentResult.Key.timestamp)
            .queryLimited(toLast: limit)
    }
    
}
