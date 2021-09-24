//
//  ArticleDetailsViewController.swift
//  RobertsJeanai09
//
//  Created by Nai Roberts on 8/25/21.
//

import UIKit

class ArticleDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var articleIMG: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publishLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    var selectedArticle : Article!
    var selectedSource: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // View is identified in the navigation bar
        navigationItem.title = selectedSource
        
        // freeform view that displays: Image, Title. Description, Author, Published Date
        articleIMG.image = selectedArticle.img
        titleLabel.text = selectedArticle.title
        descLabel.text = selectedArticle.desc
        authorLabel.text = selectedArticle.author
        publishLabel.text  = selectedArticle.publishedDate
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! WebViewController
        destination.selectedSource = selectedSource
        destination.selectedArticleURL = URL(string: selectedArticle.url)
    }
    
    // MARK: View Article Button
    // freeform view will display
    @IBAction func viewButton(_ sender: Any) {
        performSegue(withIdentifier: "segue_ID2", sender: self)
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
