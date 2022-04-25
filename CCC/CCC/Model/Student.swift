//
//  Student.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 13.04.22.
//

import Foundation
import UIKit

struct Student {
    let id: String
    var parentId: String
    let firstName: String
    let lastName: String
    var rollNumber: String
    let cnic: String
    var photoUrlString: String
    var hasLeft = false
    var currentClass: String
    
    var fullName: String { "\(firstName) \(lastName)" }
    var dictionary: [String: Any] {
        [
            Key.id: id,
            Key.parentId: parentId,
            Key.firstName: firstName,
            Key.lastName: lastName,
            Key.rollNumber: rollNumber,
            Key.cnic: cnic,
            Key.photoUrl: photoUrlString,
            Key.hasLeft: hasLeft,
            Key.currentClass: currentClass
        ]
    }
    
    init(parentId: String, firstName: String, lastName: String, rollNumber: String,
         cnic: String, photoUrlString: String, currentClass: String) {
        self.id = UUID().uuidString
        self.parentId = parentId
        self.firstName = firstName
        self.lastName = lastName
        self.rollNumber = rollNumber
        self.cnic = cnic
        self.photoUrlString = photoUrlString
        self.currentClass = currentClass
    }
    
    init(from dictionary: [String: Any]) {
        id = dictionary[Key.id] as! String
        parentId = dictionary[Key.parentId] as! String
        firstName = dictionary[Key.firstName] as! String
        lastName = dictionary[Key.lastName] as! String
        rollNumber = dictionary[Key.rollNumber] as! String
        cnic = dictionary[Key.cnic] as! String
        photoUrlString = dictionary[Key.photoUrl] as! String
        currentClass = dictionary[Key.currentClass] as! String
        hasLeft = dictionary[Key.hasLeft] as! Bool
    }
    
    struct Key {
        static let id = "id"
        static let parentId = "parent_id"
        static let firstName = "first_name"
        static let lastName = "last_name"
        static let rollNumber = "roll_number"
        static let cnic = "cnic"
        static let photoUrl = "photo_url"
        static let hasLeft = "hast_left"
        static let currentClass = "current_class"
    }
}
