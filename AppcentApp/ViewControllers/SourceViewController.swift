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
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews(){
//        TODO: Delegate kismini svprogresshud ile al yuklenirken bir sey gozuksun.
        newWebView.navigationDelegate = self
        
        let url = URL(string: "https://developer.apple.com")!
        newWebView.load(URLRequest(url: url))
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
