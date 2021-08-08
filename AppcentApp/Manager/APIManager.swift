//
//  APIManager.swift
//  AppcentApp
//
//  Created by Ali Kose on 7.08.2021.
//

import Foundation

final class APIManager {
    static let shared = APIManager()

/*
     https://newsapi.org/v2/everything?q=besiktas&amp&page=1&amp&apiKey=1ef4d15934bf4adbbfed86496ca71979
     */
    private init(){}
    
    public func getNews( page : Int, completion: @escaping (Result<[Article],Error >) -> Void ) {
         let baseURL = URL(string: "https://newsapi.org/v2/everything?q=google&page=\(page)&apiKey=1ef4d15934bf4adbbfed86496ca71979")
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
                    completion(.success(result.articles))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
