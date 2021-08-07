//
//  FavoritesViewController.swift
//  AppcentApp
//
//  Created by Ali Kose on 7.08.2021.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var favoritesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    func setupView(){
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
    }
}

extension FavoritesViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoritesTableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell") as! FavoritesTableViewCell
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
