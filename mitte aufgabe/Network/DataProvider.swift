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
            
            if let error = error {
                
                completion(.failure(error))
            }
            
            guard let data = receivedData else {
                
                completion(.failure(NetworkError.customDescriptionError("No data received")))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            guard let decoded = try? jsonDecoder.decode([T].self, from: data) else {
                
                completion(.failure(NetworkError.customDescriptionError("Decoding Error")))
                return
            }

            completion(.success(decoded))
        }
        
        urlSession.resume()
    }
}
