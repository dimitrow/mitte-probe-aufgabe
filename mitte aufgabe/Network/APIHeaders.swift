//
//  APIHeaders.swift
//  mitte aufgabe
//
//  Created by Gene Dimitrow on 22.08.21.
//

import Foundation

public typealias HTTPHeader = [String: String]

struct HTTPHeaderKeys {
    
    static let authorization = "Authorization"
}

protocol APIHeader {
    
    var authenticationHeader: HTTPHeader { get }
}

extension APIHeader {
    
    var authenticationHeader: HTTPHeader {
        
        var header = HTTPHeader()
        
        let userName: String = "api-client"
        let password = "M28F^@q4d_#$"
        
        if let encodedValue = buildAuthentication(userName, password: password) {
            
            header[HTTPHeaderKeys.authorization] = "Basic \(encodedValue)"
        }
        
        return header
    }
    
    private func buildAuthentication(_ userName: String, password: String) -> String? {
        
        let credentialsString = "\(userName):\(password)"
        
        let utf8str = credentialsString.data(using: .utf8)
        
        if let base64Encoded = utf8str?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0)) {
            
            return base64Encoded
        }
        
        return nil
    }
}
