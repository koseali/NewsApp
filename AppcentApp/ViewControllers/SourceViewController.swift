//
//  SourceViewController.swift
//  AppcentApp
//
//  Created by Ali Kose on 7.08.2021.
//

import UIKit
import WebKit

class SourceViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var newWebView: WKWebView!
    public var newURL : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews(){
        newWebView.navigationDelegate = self

       let url = URL(string: newURL)!
        newWebView.load(URLRequest(url: url))
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
