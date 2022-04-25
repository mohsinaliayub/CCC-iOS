//
//  ResultsManager.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 25.04.22.
//

import Foundation
import FirebaseDatabase

protocol ResultsManager {
    func addResult(_: StudentResult, completion: @escaping (Error?) -> Void)
    func fetchResults(for: String, completion: @escaping ([StudentResult], Error?) -> Void)
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
    
    func fetchResults(for studentId: String, completion: @escaping ([StudentResult], Error?) -> Void) {
        
    }
    
    
}
