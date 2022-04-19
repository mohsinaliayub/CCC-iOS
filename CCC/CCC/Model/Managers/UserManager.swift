//
//  UserManager.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 19.04.22.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

protocol UserManager {
    func saveUser(user: User, completion: @escaping (Error?) -> Void)
}

class FirestoreUserManager: UserManager {
    
    private let usersCollection = Firestore.firestore().collection("Users")
    
    func saveUser(user: User, completion: @escaping (Error?) -> Void) {
        usersCollection.document(user.id).setData(user.dictionary) { error in
            completion(error)
        }
    }
    
}
