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
        
        let session = URLSession.shared
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "mocki.io"
        urlComponents.path = "/v1/be9d3685-4800-4f7c-95e0-1d70b38c603a"
        
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
