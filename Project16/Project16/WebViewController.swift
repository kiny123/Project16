//
//  WebViewController.swift
//  Project16
//
//  Created by nikita on 20.02.2023.
//

import WebKit
import UIKit

class WebViewController: UIViewController {
    @IBOutlet var webView: WKWebView!
    
    
    var url: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard url != nil else {
                   print("Website not set")
                   navigationController?.popViewController(animated: true)
                   return
               }
        if let url = URL(string: url ?? "https://www.google.com/") {
                     webView.load(URLRequest(url: url))
                 }

    }
    

    
}
