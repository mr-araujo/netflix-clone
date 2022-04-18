//
//  APICaller.swift
//  Netflix-Clone
//
//  Created by Murillo R. Araújo on 18/04/22.
//

import Foundation

enum APIError: Error {
    case noData
    case noResponse
    case invalidKey
    case invalidURL
}

class APICaller {
    
    static let shared = APICaller()
    
    func fetchData(completion: @escaping (Result<[Movie], APIError>) -> Void) {
        
        let baseURL = "https://api.themoviedb.org"
        
        guard let apiKey = ProcessInfo.processInfo.environment["API_KEY"] else {
            return completion(.failure(.invalidKey))
        }
        
        guard let url = URL(string: "\(baseURL)/3/trending/all/day?api_key=\(apiKey)") else {
            return completion(.failure(.invalidURL))
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noResponse))
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let movies = try decoder.decode(Movies.self, from: data)
                completion(.success(movies.results))
            } catch {
                completion(.failure(.noData))
            }
        }
        task.resume()
    }
}
