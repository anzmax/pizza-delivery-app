//
//  CategoriesNetworkService.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 15.03.2024.
//

import UIKit

protocol CategoriesNetworkServiceProtocol: AnyObject {
    func fetchCategory(completion: @escaping (Result<[Category], NetworkError>) -> Void)
}

class CategoriesNetworkService: CategoriesNetworkServiceProtocol {
    
    func fetchCategory(completion: @escaping (Result<[Category], NetworkError>) -> Void) {
        
        let session = URLSession.shared
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "mocki.io"
        urlComponents.path = "/v1/5f0614ce-71fb-445a-8640-6f84ed2bdf43"
        
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
                let specials  = try JSONDecoder().decode([Category].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(specials))
                }
            } catch {
                completion(.failure(.parsingInvalid))
                print(error)
            }
        }.resume()
    }
}


