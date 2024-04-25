//
//  NetworkErrors.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 15.03.2024.
//

import Foundation

enum NetworkError: Error {
   case emptyUrl
   case emptyJson
   case parsingInvalid
}
