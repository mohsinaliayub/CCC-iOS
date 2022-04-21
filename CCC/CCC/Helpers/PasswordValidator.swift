//
//  PasswordValidator.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 21.04.22.
//

import Foundation

struct PasswordValidator {
    
    private static let passwordLength = 8
    
    static func validate(_ password: String) -> Bool {
        !password.isEmpty && (password.count >= passwordLength)
    }
    
}
