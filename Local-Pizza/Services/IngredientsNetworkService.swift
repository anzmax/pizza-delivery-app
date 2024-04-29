//
//  IngredientsNetworkService.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 25.03.2024.
//

import UIKit

protocol IngredientsNetworkServiceProtocol: AnyObject {
    func fetchIngredients(completion: @escaping (Result<[Ingredient], NetworkError>) -> Void)
}

class IngredientsNetworkService: IngredientsNetworkServiceProtocol {
    
    func fetchIngredients(completion: @escaping (Result<[Ingredient], NetworkError>) -> Void) {
        
        let session = URLSession.shared
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "mocki.io"
        urlComponents.path = "/v1/94891cd2-f226-4c45-a410-4d4408e5dad6"
        
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
                let ingredients = try JSONDecoder().decode([Ingredient].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(ingredients))
                }
            } catch {
                completion(.failure(.parsingInvalid))
                print(error)
            }
        }.resume()
    }
    
}
