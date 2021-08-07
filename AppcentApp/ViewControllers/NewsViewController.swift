//
//  NewsViewController.swift
//  AppcentApp
//
//  Created by Ali Kose on 7.08.2021.
//

import UIKit
import Kingfisher

class NewsViewController: UIViewController {
  
// MARK: -IBOUTLETS
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var news = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIManager.shared.getNews { [weak self] result in
            switch result {
            case .success(let articles):
//                print("Articles dolu geliyor ama : \(articles)")
//                 TODO ALERT : optional burda kaldirdim.
                self!.news = articles.compactMap({
                    Article(source: $0.source, author: $0.author, publishedAt: $0.publishedAt, title: $0.title, description: $0.description, urlToImage: $0.urlToImage, url: $0.url)
                  
                })
                DispatchQueue.main.async {
                    self?.newsTableView.reloadData()
                }
                
//                print("Abi NEws burda")
//                print(self!.news)
                break
            case .failure(let error):
                print("Api Error: \(error)")
            }
            
        }
        setupView()
      
    }
    func setupView(){
        newsTableView.delegate = self
        newsTableView.dataSource = self
    }

    @IBAction func clearSearchButtonTapped(_ sender: Any) {
        searchTextField.text = ""
    }
    @IBAction func searchButtonTapped(_ sender: Any) {
        print("Search Yapma fonksiyonu tableview reload at")
    }
}



extension NewsViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as! NewsTableViewCell
        let item = news[indexPath.row]
        cell.titleLabel.text = item.title
        cell.subtitleLabel.text = item.description
        cell.setCollectionViewCell(imageUrl: item.urlToImage)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        pushViewController(DetailsViewController.self)
    }
   
}

