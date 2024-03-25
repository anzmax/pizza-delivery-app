//
//  StoriesNetworkService.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 15.03.2024.
//

import UIKit

class StoriesNetworkService {
    
    func fetchStory(completion: @escaping (Result<[Story], NetworkError>) -> Void) {
        
        //https://mocki.io/v1/5bb6cd50-fa07-4628-98cb-c70938493f9f
        
        let session = URLSession.shared
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "mocki.io"
        urlComponents.path = "/v1/5bb6cd50-fa07-4628-98cb-c70938493f9f"
        
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

