//
//  APIManager.swift
//  AppcentApp
//
//  Created by Ali Kose on 7.08.2021.
//

import Foundation

final class APIManager {
    static let shared = APIManager()

    private init(){}
    
    public func getNews(search: String, page : Int, completion: @escaping (Result<News,Error >) -> Void ) {
        let apiKey = "4e3e17dd59234168891ffce8d14493fc"
         let baseURL = URL(string:"https://newsapi.org/v2/everything?q=\(search)&amp&page=\(page)&amp&apiKey=\(apiKey)")
        guard let url = baseURL else{
            return
        }
    
        let task = URLSession.shared.dataTask(with: url) { data , _ , error in
            
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(News.self, from: data)
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
