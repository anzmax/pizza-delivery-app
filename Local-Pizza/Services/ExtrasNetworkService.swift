//
//  ExtrasNetworkService.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 15.03.2024.
//

import UIKit

protocol ExtrasNetworkServiceProtocol: AnyObject {
    func fetchProducts(completion: @escaping (Result<[Product], NetworkError>) -> Void)
}

class ExtrasNetworkService: ExtrasNetworkServiceProtocol {
    
    func fetchProducts(completion: @escaping (Result<[Product], NetworkError>) -> Void) {
        
        //https://mocki.io/v1/45f9617c-9d2e-4054-af67-2002ef530440
        
        let session = URLSession.shared
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "mocki.io"
        urlComponents.path = "/v1/45f9617c-9d2e-4054-af67-2002ef530440"
        
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
