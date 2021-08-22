//
//  ErrorHandling.swift
//  mitte aufgabe
//
//  Created by Gene Dimitrow on 22.08.21.
//

import Foundation

enum NetworkError: Error {
    
    case missedData
    case customDescriptionError(_ description: String)
}
