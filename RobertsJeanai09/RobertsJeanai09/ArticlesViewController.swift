//
//  ArticlesViewController.swift
//  RobertsJeanai09
//
//  Created by Nai Roberts on 8/25/21.
//

import UIKit

class ArticlesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var selectedSource : Source!
    var articles = [Article]()
    private let apiKey = "d353f7814e714a508b27d869baea7575"
    
    @IBOutlet weak var articlesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // View is identified in the navigation bar
        navigationItem.title = "\(selectedSource.name)"
        
        // Download articles from selected source
        let dwnldString = "https://newsapi.org/v1/articles?source=\(selectedSource.id)&apiKey=\(apiKey)"
        
        // Method to dowload data from URL string
        downloadJson(atUrl: dwnldString)
       
        
    }
    // Method for the height of the cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    // Method for the number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    
    // MARK: Cell Creation
    // Method to Create, Configure and Display the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuse_ID2", for: indexPath) as? articlesTableViewCell
        else{
            return tableView.dequeueReusableCell(withIdentifier: "reuse_ID2", for: indexPath)
        }
        
        let currentArticle = articles[indexPath.row]
        
        // Custom Cells displays the article title and associated image.
        cell.titleLabel.text = currentArticle.title
        
        cell.articleImage.image = currentArticle.img
            
        
        
        
        
        return cell
        
    }
    
    // MARK: Download Method
    // Method to download data from provided URL
    func downloadJson(atUrl urlString: String){
        
        // set up the download
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // create url
        if let URL = URL(string: urlString){
            // create task
            let task = session.dataTask(with: URL, completionHandler: { (urlData, response, error) in
                
                // check if error is empty
                if error != nil {assertionFailure(); return}
                
                // check the response, statusCode, and data
                guard let response = response as? HTTPURLResponse, response.statusCode == 200, let data = urlData
                else {assertionFailure(); return}
                
                // deserialize data
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any]{
                        
                        // parse the data
                        guard let articleData = json["articles"] as? [[String: Any]]
                        else{assertionFailure(); return}
                        
                        
                        for article in articleData{
                            if let author = article["author"] as? String,
                               let title = article["title"] as? String,
                               let desc = article["description"] as? String,
                               let url = article["url"] as? String,
                               let imgURL = article["urlToImage"] as? String,
                               let publishedDate = article["publishedAt"] as? String{
                                
                                self.articles.append(Article(imgURL: imgURL, url: url, title: title, desc: desc, author: author, publishedDate: publishedDate))
                                
                            }
                        }
                    }
                    
                    
                }
                catch{
                    print(error.localizedDescription)
                    assertionFailure();
                }
                
                DispatchQueue.main.async {
                    self.AddImg()
                    self.articlesTableView.reloadData()

                }
                
                
            })
            
            // start the task
            task.resume()
        }
        
        
        
    }
    
    // Method to add image to cell
    func AddImg(){
        for article in articles{
            if let url = URL(string: article.imgURL){
                do{
                    let img = try Data(contentsOf: url)
                    if let articleImg = UIImage(data: img){
                        article.img = articleImg
                    }
                    
                    
                }
                catch{
                    article.img = UIImage(named: "defaultImage")
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // Back button takes the user to the Articles View (not the Detail View).
    @IBAction func unwind(segue: UIStoryboardSegue){
        if let source = segue.source as? ArticlesViewController{
            self.present(source, animated: true, completion: nil)
        }
        
    }

    
    // MARK: - Navigation

    // Cell selection takes the user to an article detail View.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destination = segue.destination as? ArticleDetailsViewController
        
        if let indexPath = articlesTableView.indexPathForSelectedRow{
            
            let selectedArticle = articles[indexPath.row]
            
            destination?.selectedArticle = selectedArticle
            
            destination?.selectedSource = selectedSource.name
            
        }
        
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
