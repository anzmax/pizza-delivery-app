//
//  CategoriesNetworkService.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 15.03.2024.
//

import UIKit

class CategoriesNetworkService {
    
    func fetchCategory(completion: @escaping (Result<[Category], NetworkError>) -> Void) {
        
        //https://mocki.io/v1/e2fc9381-2fdc-42af-be2a-c966a8a80e36
        
        let session = URLSession.shared
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "mocki.io"
        urlComponents.path = "/v1/e2fc9381-2fdc-42af-be2a-c966a8a80e36"
        
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


