//
//  DetailsViewController.swift
//  AppcentApp
//
//  Created by Ali Kose on 7.08.2021.
//

import UIKit

class DetailsViewController: UIViewController {
    
// MARK: -IBOutlets
    @IBOutlet weak var newImageView: UIImageView!
    @IBOutlet weak var newTitleLabel: UILabel!
    @IBOutlet weak var authorButton: UIButton!
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var newDescriptionTextView: UITextView!
// MARK: -LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
}
    
    func setupViews(){
        newTitleLabel.text = "Tum Takimlar Kardestir"
        authorButton.isUserInteractionEnabled = false
        authorButton.setTitle("Ali Kose", for: .normal)
        dateButton.isUserInteractionEnabled = false
        
        newDescriptionTextView.text = "Fenerbahçe futbol takımı, Fenerbahçe Spor Kulübü'nün Süper Lig'de mücadele eden profesyonel futbol takımıdır. Kulübün futbol dışında faaliyet gösterdiği diğer spor dalları basketbol, voleybol, atletizm, boks, kürek, yelken, yüzme, e-Spor ve masa tenisi'dir.Fenerbahçe futbol takımı, Fenerbahçe Spor Kulübü'nün Süper Lig'de mücadele eden profesyonel futbol takımıdır. Kulübün futbol dışında faaliyet gösterdiği diğer spor dalları basketbol, voleybol, atletizm, boks, kürek, yelken, yüzme, e-Spor ve masa tenisi'dir.Fenerbahçe futbol takımı, Fenerbahçe Spor Kulübü'nün Süper Lig'de mücadele eden profesyonel futbol takımıdır. Kulübün futbol dışında faaliyet gösterdiği diğer spor dalları basketbol, voleybol, atletizm, boks, kürek, yelken, yüzme, e-Spor ve masa tenisi'dir.Fenerbahçe futbol takımı, Fenerbahçe Spor Kulübü'nün Süper Lig'de mücadele eden profesyonel futbol takımıdır. Kulübün futbol dışında faaliyet gösterdiği diğer spor dalları basketbol, voleybol, atletizm, boks, kürek, yelken, yüzme, e-Spor ve masa tenisi'dir."
        newImageView.image = UIImage(named: "besiktas")
    }
    
// MARK: -IBActions
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    // self.navigationController?.popViewController(animated: true)
    @IBAction func newSourceButtonTapped(_ sender: Any) {
        pushViewController(SourceViewController.self)
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
//        TODO: favorite duzenle burada goster.
        
//        var likedWallpapers = Defaults[.likedWallpapers]
//        if likedWallpapers.contains(self.wallpaper.thumbnailUrl){
//            likedWallpapers = likedWallpapers.filter(){ $0 != self.wallpaper.thumbnailUrl }
//        }
//        else {
//            likedWallpapers.append(self.wallpaper.thumbnailUrl)
//        }
//        Defaults[.likedWallpapers] = likedWallpapers
    }
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        let urlString = "https://www.appcent.mobi/"
        if let url = URL(string: urlString) {
            let activityViewController = UIActivityViewController(
                activityItems: [url],
                applicationActivities: nil
            )
            
            // for iPAD
            if let popoverPresentationController = activityViewController.popoverPresentationController {
                popoverPresentationController.sourceView = self.view
                popoverPresentationController.sourceRect = CGRect(
                    x: self.view.bounds.midX,
                    y: self.view.bounds.maxY - 120,
                    width: 1,
                    height: 1
                )
            }
            present(activityViewController, animated: true)
        }

        
    }
    
}
