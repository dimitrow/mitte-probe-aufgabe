//
//  ErrorHandling.swift
//  mitte aufgabe
//
//  Created by Gene Dimitrow on 22.08.21.
//

import Foundation

enum NetworkError: Error {
    
    case missedData
    case decodingError
    case customDescriptionError(_ description: String)
}

extension NetworkError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .missedData:
            return "No data received"
        case .decodingError:
            return "Decoding Error"
        case .customDescriptionError(let description):
            return description
        }
    }
}


