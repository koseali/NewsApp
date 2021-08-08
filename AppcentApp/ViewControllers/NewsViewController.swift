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
    var pageNumber = 1
    var searchText = "google"
    var searchh = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData(search : searchText ,pageNum: pageNumber)
        setupView()
        searchText = searchh
    }
    func loadData(search: String , pageNum : Int) {
        APIManager.shared.getNews(search: search, page: pageNum) { [weak self] result in
            switch result {
            case .success(let articles):
                let data = articles.compactMap({
                    Article(source: $0.source, author: $0.author, publishedAt: $0.publishedAt, title: $0.title, description: $0.description, urlToImage: $0.urlToImage, url: $0.url)
                })
                
                if self!.searchh == self!.searchText{
                    self!.news.append(contentsOf: data)
                }
                else{
                    self!.news.removeAll()
                    self!.searchh = self!.searchText
                    self!.news.append(contentsOf: data)
                }
                
                DispatchQueue.main.async {
                    self?.newsTableView.reloadData()
                }
                break
            case .failure(let error):
                print("Api Error: \(error)")
            }
            
        }
        
    }
    
    func setupView(){
        newsTableView.delegate = self
        newsTableView.dataSource = self
    }
    
    @IBAction func clearSearchButtonTapped(_ sender: Any) {
        searchTextField.text?.removeAll() 
    }
    @IBAction func searchButtonTapped(_ sender: Any) {
        searchText = searchTextField.text ?? ""
        loadData(search: searchText, pageNum: pageNumber)
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
        
        cell.setNewTableViewCell(title: item.title, subtitle: item.description, imageUrl: item.urlToImage)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("Detaya Gidilen Haber: ")
        print(news[indexPath.row])
        pushDetailsViewController(news, indexPath)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //        scrollView.contentSize.height veri akdar asagi inmesi
        //        scrollView.frame.size.height bu da ekranin frame yuksekligi
        //        birtane de oldugum konumu alinca scrollView.contentSize.height ve konum cikmasi scrollView.frame.size.height buyukse page arttir
        //        scrollView.contentOffset.y
        print("Ekranin yuksekligi : \(scrollView.frame.size.height)")
        print("Verinin yuksekligi : \(scrollView.contentSize.height)")
        print("bulunan y konumu: \(scrollView.contentOffset.y)")
        
        print(scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height)
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height {
            loadData(search: searchText, pageNum: pageNumber+1)
        }
    }
}

