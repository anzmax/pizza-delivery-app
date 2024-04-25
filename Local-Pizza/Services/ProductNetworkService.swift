//
//  ProductNetworkService.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 15.03.2024.
//

import UIKit

protocol ProductNetworkServiceProtocol: AnyObject {
    func fetchProducts(completion: @escaping (Result<[Product], NetworkError>) -> Void)
}

class ProductNetworkService: ProductNetworkServiceProtocol {
    
    func fetchProducts(completion: @escaping (Result<[Product], NetworkError>) -> Void) {

        //https://mocki.io/v1/cc2a8f8a-b52c-4dd0-bb4f-0e70416f25af
        
        let session = URLSession.shared
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "mocki.io"
        urlComponents.path = "/v1/cc2a8f8a-b52c-4dd0-bb4f-0e70416f25af"
        
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
