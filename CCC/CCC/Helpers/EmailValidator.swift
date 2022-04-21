//
//  EmailValidator.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 21.04.22.
//

import Foundation

struct EmailValidator {
    
    private static let pattern = "^[_A-Za-z0-9-+]+(\\.[_A-Za-z0-9-+]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z‌​]{2,})$"
    
    static func validate(with input: String) -> Bool {
        NSPredicate(format: "SELF Matches %@", pattern).evaluate(with: input)
    }
    
}
