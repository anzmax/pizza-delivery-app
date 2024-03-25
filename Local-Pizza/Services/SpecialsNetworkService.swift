//
//  SpecialsNetworkService.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 15.03.2024.
//

import UIKit

class SpecialsNetworkService {
    
    func fetchSpecials(completion: @escaping (Result<[Special], NetworkError>) -> Void) {
        
        //https://mocki.io/v1/0eb535a1-0b36-4096-901d-77347ee9ccc1
        
        let session = URLSession.shared
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "mocki.io"
        urlComponents.path = "/v1/0eb535a1-0b36-4096-901d-77347ee9ccc1"
        
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
                let specials  = try JSONDecoder().decode([Special].self, from: data)
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

