//
//  User.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 19.04.22.
//

import Foundation

struct User: Codable {
    
    let id: String
    var email: String
    var firstName: String
    var lastName: String
    var phoneNumber: String?
    var profilePhotoUrlString: String?
    var fullName: String { "\(firstName) \(lastName)" }
    
    var dictionary: [String: Any] {
        [
            Constants.id: id,
            Constants.email: email,
            Constants.firstName: firstName,
            Constants.lastName: lastName,
            Constants.phoneNumber: phoneNumber as Any,
            Constants.profilePhotoUrlString: profilePhotoUrlString as Any
        ]
    }
    
    init(id: String, email: String, firstName: String, lastName: String,
         phoneNumber: String? = nil, profilePhotoUrlString: String? = nil) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.profilePhotoUrlString = profilePhotoUrlString
    }
    
    private struct Constants {
        static let id = "id"
        static let email = "email"
        static let firstName = "first_name"
        static let lastName = "last_name"
        static let phoneNumber = "phone_number"
        static let profilePhotoUrlString = "profile_photo_url"
    }
    
}

extension User {
    
    init(from dictionary: [String: Any]) {
        id = dictionary[Constants.id] as! String
        email = dictionary[Constants.email] as! String
        firstName = dictionary[Constants.firstName] as! String
        lastName = dictionary[Constants.lastName] as! String
        phoneNumber = dictionary[Constants.phoneNumber] as? String
        profilePhotoUrlString = dictionary[Constants.profilePhotoUrlString] as? String
    }
    
}
