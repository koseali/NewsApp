//
//  FavoritesViewController.swift
//  AppcentApp
//
//  Created by Ali Kose on 7.08.2021.
//

import UIKit
import Defaults
import Kingfisher
import SVProgressHUD

class FavoritesViewController: UIViewController {
    
    var favoriteNews = Defaults[.favoriteNews]

    @IBOutlet weak var favoritesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        favoriteNews = Defaults[.favoriteNews]
        favoritesTableView.reloadData()
        if favoriteNews.isEmpty {
            SVProgressHUD.setDefaultMaskType(.none)
            SVProgressHUD.showInfo(withStatus:"There is no favorite news. You can add it from the new screen.")
        }
    }
 
    func setupView(){
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
    }
}

extension FavoritesViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoritesTableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell") as! FavoritesTableViewCell
        let item = favoriteNews[indexPath.row]
        cell.titleLabel.text = item.title
        cell.subtitleLabel.text = item.description
        
        let imageURL = URL(string: item.urlToImage)
        cell.newImageView.kf.indicatorType = .activity
        cell.newImageView.kf.setImage(with: imageURL , placeholder: UIImage(named: "blankImage"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        pushDetailsViewController(favoriteNews, indexPath)

    }
    
    
}
