//
//  StoriesNetworkService.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 15.03.2024.
//

import UIKit

protocol StoriesNetworkServiceProtocol: AnyObject {
    func fetchStory(completion: @escaping (Result<[Story], NetworkError>) -> Void)
}

class StoriesNetworkService: StoriesNetworkServiceProtocol {
    
    func fetchStory(completion: @escaping (Result<[Story], NetworkError>) -> Void) {
        
        let session = URLSession.shared
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "mocki.io"
        urlComponents.path = "/v1/4f3f11bb-8c7d-4b3b-b0ab-3269ec03bf6d"
        
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
                let specials  = try JSONDecoder().decode([Story].self, from: data)
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

