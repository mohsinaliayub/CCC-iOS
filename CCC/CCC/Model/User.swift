//
//  User.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 19.04.22.
//

import Foundation

struct User: Codable {
    
    var email: String
    var firstName: String
    var lastName: String
    var phoneNumber: String?
    var profilePhotoUrlString: String?
    var isVerified = false
    
    enum CodingKeys: String, CodingKey {
        case email, firstName, lastName, phoneNumber
        case profilePhotoUrlString = "profilePhotoUrl"
        case isVerified = "verified"
    }
    
}
