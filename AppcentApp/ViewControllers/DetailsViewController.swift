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
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var newDescriptionTextView: UITextView!
    
    // MARK: -Variables
    public var news = [Article]()
    public var indexPath = IndexPath(row: 0, section: 0)
    
    // MARK: -LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        print("KAydedilen Favori Haberler")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setFavoriteButton()
    }
    //    MARK: -Functions
    
    func setupViews(){
        let item = news[indexPath.row]

        setDetailsViewData(title: item.title, description: item.description, author: item.author, publishedAt: item.publishedAt, imageURL: item.urlToImage)
    }
    
    func setDetailsViewData(title : String , description : String , author : String, publishedAt : String , imageURL : String) {

        newTitleLabel.text = title
        
        authorButton.isUserInteractionEnabled = false
        authorButton.setTitle(author, for: .normal)
        
        dateButton.isUserInteractionEnabled = false
        dateButton.setTitle(formatDate(date: publishedAt), for: .normal)
        
        newDescriptionTextView.text = description

        let imageURL = URL(string: imageURL)
        newImageView.kf.indicatorType = .activity
        newImageView.kf.setImage(with: imageURL , placeholder: UIImage(named: "blankImage"))
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
    
    func setFavoriteButton(){
        
        var favoriteNew = Defaults[.favoriteNew]
        favoriteNew = news[indexPath.row]
        
        let favoriteNews = Defaults[.favoriteNews]
        
        let size =  favoriteNews.count
        var flag = true
//        ALERT : TODO : Favorite Listesi 0 sa durumu
        if size != 0 {
            for index in 0...size-1 {
                if favoriteNews[index].url == favoriteNew.url {
                    favoriteButton.isSelected = true
                    flag = false
                }
            }
        }
        if flag == true {
            favoriteButton.isSelected = false
        }
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
