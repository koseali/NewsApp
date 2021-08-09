//
//  AppDelegate.swift
//  AppcentApp
//
//  Created by Ali Kose on 7.08.2021.
//

import UIKit
import Defaults

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
}

extension Defaults.Keys {
    
    static let favoriteNew = Key<Article>("favoriteNew",default : Article(source: Source(name: "unnamed"), author: "Ali Kose", publishedAt: "Time", title: "null", description: "null", urlToImage: "null", url: "null"))
    
    static let favoriteNews = Key<[Article]>("favoriteNews",default : [])

}


