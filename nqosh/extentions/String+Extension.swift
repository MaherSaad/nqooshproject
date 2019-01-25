//
//  String+Extension.swift
//  webservicesDemo
//
//  Created by Ahmed Elzohry on 1/31/17.
//  Copyright © 2017 Ahmed Elzohry. All rights reserved.
//

import Foundation
extension String {
    
    var trim: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
}
extension Optional {
    func getOrElse<T>(defaultValue: T) -> T {
        if let value = self {
            return value as! T
        } else {
            return defaultValue
        }
    }
}
