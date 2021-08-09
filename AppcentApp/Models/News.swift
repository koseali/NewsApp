//
//  News.swift
//  AppcentApp
//
//  Created by Ali Kose on 7.08.2021.
//

import Foundation

struct News : Codable {
   let  articles : [Article]
    let totalResults : Int
    
}
struct Article : Codable {
    let source : Source
    
    let author : String
    let publishedAt : String
    
    let title : String
    let description : String
    let urlToImage : String
    
    let url : String
    
}

struct Source : Codable {
    let name : String
}
