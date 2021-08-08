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
    
    public func getNews(search: String, page : Int, completion: @escaping (Result<News,Error >) -> Void ) {
         let baseURL = URL(string:"https://newsapi.org/v2/everything?q=\(search)&amp&page=\(page)&amp&apiKey=978723300d8a461e91dd48272c2df980")
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
