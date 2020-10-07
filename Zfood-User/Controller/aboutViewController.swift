//
//  aboutViewController.swift
//  Zfood-User
//
//  Created by bhavya on 3/13/20.
//  Copyright © 2020 WemakeAppz. All rights reserved.
//

import UIKit
import WebKit
class aboutViewController: UIViewController {

    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var webview: WKWebView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    var urlN = ""
    var titleN = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = titleN
        let url = URL(string: urlN)!
        webview.load(URLRequest(url: url))
        webview.navigationDelegate = self
        webview.allowsBackForwardNavigationGestures = true
    }
    @IBAction func handleBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
extension aboutViewController : WKNavigationDelegate{
   
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
         self.loader.stopAnimating()
               self.loader.isHidden = true
    }
}
