//
//  NewsViewController.swift
//  AppcentApp
//
//  Created by Ali Kose on 7.08.2021.
//

import UIKit
import Kingfisher
import SVProgressHUD
class NewsViewController: UIViewController {
    
    // MARK: -IBOUTLETS
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var newsSearchBar: UISearchBar!
    
    // MARK: -Variables
    
    var news = [Article]()
    var pageNumber = 1
    var searchText = "new"
    var totalResults = 0
    
    // MARK: -Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadData(search: searchText ,pageNum: pageNumber)
    }
    
    // MARK: -Functions
    
    func setupView(){
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsSearchBar.delegate = self
    }
    
    func loadData( search : String, pageNum : Int) {
        APIManager.shared.getNews(search:search, page: pageNum) { [weak self] result in
            switch result {
            case .success(let news):
                let data = news.articles.compactMap({
                    Article(source: $0.source, author: $0.author, publishedAt: $0.publishedAt, title: $0.title, description: $0.description, urlToImage: $0.urlToImage, url: $0.url)
                    
                })
                self?.totalResults = news.totalResults
                self!.news.append(contentsOf: data)
                print("Toplam Eleman: \(self!.totalResults)")
                print("Haber Sayisi: \(self!.news.count)")
                if self!.news.isEmpty {
                    SVProgressHUD.setDefaultMaskType(.none)
                    SVProgressHUD.showInfo(withStatus:"Couldn't Find Any Result Please Search Again.")
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
}

//    MARK: -Extension for TableView

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
        print("Ekranin yuksekligi : \(scrollView.frame.size.height)")
        print("Verinin yuksekligi : \(scrollView.contentSize.height)")
        print("bulunan y konumu: \(scrollView.contentOffset.y)")
        
        print(scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height)
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height {
            guard news.count < totalResults else {
                return
            }
            loadData( search: searchText, pageNum: pageNumber+1)
        }
    }
}
//    MARK: -Extension for Searchbar
extension NewsViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else{
            SVProgressHUD.setDefaultMaskType(.none)
            SVProgressHUD.showInfo(withStatus:"Search key is empty. Please write search key.")
            return}
        print(searchText)
        news.removeAll()
        pageNumber = 1
        loadData(search: searchText, pageNum: pageNumber)
        
        newsTableView.reloadData()
        
    }
}

