//
//  DetailsViewController.swift
//  AppcentApp
//
//  Created by Ali Kose on 7.08.2021.
//

import UIKit
import Defaults
import Kingfisher
class DetailsViewController: UIViewController {
    
    // MARK: -IBOutlets
    @IBOutlet weak var newImageView: UIImageView!
    @IBOutlet weak var newTitleLabel: UILabel!
    @IBOutlet weak var authorButton: UIButton!
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var newDescriptionTextView: UITextView!
    // MARK: -Variables
    public var news = [Article]()
    public var indexPath = IndexPath(row: 0, section: 0)
    // MARK: -LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        print("KAydedilen Favori Haberler")
                //        print("Gelen index \(indexPath)")
        //        print("Gelen haberler: \(news)")
    }
    //    MARK: -Functions
    func setupViews(){
        let item = news[indexPath.row]
        newTitleLabel.text = item.title
        authorButton.isUserInteractionEnabled = false
        authorButton.setTitle(item.author, for: .normal)
        dateButton.isUserInteractionEnabled = false
        dateButton.setTitle(formatDate(date: item.publishedAt), for: .normal)
        newDescriptionTextView.text = item.description
        
        let imageURL = URL(string: item.urlToImage)
        newImageView.kf.indicatorType = .activity
        newImageView.kf.setImage(with: imageURL , placeholder: UIImage(named: "blurImage"))
    }
    
    func formatDate(date : String)-> String{
        var newDate = ""
        var count = 0
        for i in date{
            if String(i) == "T" {break}
            
            else if String(i) == "-" {continue}
            
            newDate.append(i)
            count += 1
            
            if count == 4 { newDate.append("-") }
            else  if count == 6 { newDate.append("-") }
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD"
        let date = dateFormatter.date(from: newDate)
        
        dateFormatter.dateFormat = "DD-MM-YYYY"
        let goodDate = dateFormatter.string(from: date!)
        
        print("Yeni Tarih: \(goodDate)")
        return goodDate
    }
    
    // MARK: -IBActions
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    // self.navigationController?.popViewController(animated: true)
    @IBAction func newSourceButtonTapped(_ sender: Any) {
        let SourceViewController = storyboard?.instantiateViewController(
            withIdentifier: "SourceViewController"
        ) as! SourceViewController
        
        SourceViewController.newURL = news[indexPath.row].url
        
        navigationController?.pushViewController(SourceViewController, animated: true)
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        var favoriteNew = Defaults[.favoriteNew]
        favoriteNew = news[indexPath.row]
        
        var favoriteNews = Defaults[.favoriteNews]
        let size = favoriteNews.count
        
        guard !favoriteNews.isEmpty else {
             favoriteNews.append(favoriteNew)
            Defaults[.favoriteNews] = favoriteNews
            return
        }
        var flag = true
        for index in 0...size-1 {
            if favoriteNews[index].url == favoriteNew.url {
                favoriteNews.remove(at: index)
                Defaults[.favoriteNews] = favoriteNews
                flag = false
                break
            }
        }
        if flag == true {
            favoriteNews.append(favoriteNew)
            Defaults[.favoriteNews] = favoriteNews
        }
    }
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        let urlString = news[indexPath.row].url
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
