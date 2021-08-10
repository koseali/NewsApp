//
//  File.swift
//  AppcentApp
//
//  Created by Ali Kose on 7.08.2021.
//

import UIKit

extension UIViewController {
    
    func pushViewController<T: UIViewController>(_ viewController: T.Type) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "\(T.self)") as? T else { return }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func pushDetailsViewController(_ news : [Article] , _ indexpath : IndexPath) {
        
        let DetailsViewController = storyboard?.instantiateViewController(
            withIdentifier: "DetailsViewController"
        ) as! DetailsViewController
        
        DetailsViewController.news = news
        DetailsViewController.indexPath = indexpath
        navigationController?.pushViewController(DetailsViewController, animated: true)
    }
}
