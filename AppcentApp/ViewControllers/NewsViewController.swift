//
//  NewsViewController.swift
//  AppcentApp
//
//  Created by Ali Kose on 7.08.2021.
//

import UIKit

class NewsViewController: UIViewController {
  
// MARK: -IBOUTLETS
    @IBOutlet weak var newsTableView: UITableView!
    
    @IBOutlet weak var searchTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as! NewsTableViewCell
        cell.titleLabel.text = "News Title"
        cell.subtitleLabel.text = "proje gec basladim. proje gec basladim proje gec basladim"
        cell.newImageView.image = UIImage(named: "besiktas")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        pushViewController(DetailsViewController.self)
    }
}

