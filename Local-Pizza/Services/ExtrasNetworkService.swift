//
//  ExtrasNetworkService.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 15.03.2024.
//

import UIKit

class ExtrasNetworkService {
    
    func fetchProducts(completion: @escaping (Result<[Product], NetworkError>) -> Void) {
        
        //https://run.mocky.io/v3/e0a6d3d7-4160-4426-a9d5-eafde54fd68d
        
        let session = URLSession.shared
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "run.mocky.io"
        urlComponents.path = "/v3/e0a6d3d7-4160-4426-a9d5-eafde54fd68d"
        
        guard let url = urlComponents.url else {
            completion(.failure(.emptyUrl))
            return
        }
        let request = URLRequest(url: url)
        
        session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(.emptyJson))
                return
            }
            
            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(products))
                }
            } catch {
                completion(.failure(.parsingInvalid))
                print(error)
            }
        }.resume()
    }
}
