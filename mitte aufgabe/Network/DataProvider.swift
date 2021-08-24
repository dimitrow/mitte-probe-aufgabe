//
//  DataProvider.swift
//  mitte aufgabe
//
//  Created by Gene Dimitrow on 22.08.21.
//

import Foundation

class DataProvider: APIHeader {

    func fetchData<T: Decodable>(endPoint: URL, type: T.Type, completion: @escaping (Result <Array<T>, Error>) -> Void) {
        
        var urlRequest = URLRequest(url: endPoint)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue(authenticationHeader[HTTPHeaderKeys.authorization], forHTTPHeaderField: HTTPHeaderKeys.authorization)
        
        let urlSession = URLSession.shared.dataTask(with: urlRequest) { receivedData, urlResponse, error in
            
            let jsonDecoder = JSONDecoder()
            
            if let httpResponse = urlResponse as? HTTPURLResponse {
                
                guard let data = receivedData else {
                    
                    completion(.failure(NetworkError.missedData))
                    return
                }
                
                if let error = error {
                    
                    completion(.failure(error))
                }
                
                switch httpResponse.statusCode {
                case 500:
                    
                    guard let decoded = try? jsonDecoder.decode(ErrorModel.self, from: data) else {
                        
                        completion(.failure(NetworkError.decodingError))
                        return
                    }
                    print(decoded.message)
                    completion(.failure(NetworkError.customDescriptionError(decoded.message)))
                    break
                case 200:
                    
                    guard let decoded = try? jsonDecoder.decode([T].self, from: data) else {
                        
                        completion(.failure(NetworkError.decodingError))
                        return
                    }
                    completion(.success(decoded))
                    break
                default:
                    
                    break
                }
            }
        }
        
        urlSession.resume()
    }
}
