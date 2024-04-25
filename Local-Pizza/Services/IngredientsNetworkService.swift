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
        
        //https://mocki.io/v1/5cb1d662-39cf-4fe5-8b5a-ab7bf9ab7342
        
        let session = URLSession.shared
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "mocki.io"
        urlComponents.path = "/v1/5cb1d662-39cf-4fe5-8b5a-ab7bf9ab7342"
        
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
