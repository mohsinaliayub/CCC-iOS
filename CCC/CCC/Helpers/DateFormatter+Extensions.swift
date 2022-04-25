//
//  DateFormatter+Extensions.swift
//  CCC
//
//  Created by Mohsin Ali Ayub on 25.04.22.
//

import Foundation

extension Date {
    
    var shortDateString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale.current
        
        return formatter.string(from: self)
    }
    
}
