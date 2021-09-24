//
//  WebViewController.swift
//  RobertsJeanai09
//
//  Created by Nai Roberts on 8/25/21.
//

import UIKit
import WebKit


class WebViewController: UIViewController, WKUIDelegate {

    var selectedArticleURL : URL!
    var selectedSource: String!
    var backItem: UINavigationItem?

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // view opens the article in a WKWebView.
        let urlRequest = URLRequest(url: selectedArticleURL)
        webView.load(urlRequest)
        
        
        
    }
    
    // Back button takes the user to the Articles View (not the Detail View).
    override func viewWillDisappear(_ animated: Bool) {
        performSegue(withIdentifier: "unwindToArticle", sender: nil)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
