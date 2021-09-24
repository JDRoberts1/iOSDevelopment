//
//  ViewController.swift
//  RobertsJeanai09
//
//  Created by Nai Roberts on 8/25/21.
//

import UIKit

class ViewController: UIViewController {
    
    var sources = [Source]()
    var filteredSources = [[Source](),[Source](),[Source](),[Source](),[Source](),[Source]()]

    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        downloadJson(atUrl: "https://newsapi.org/v1/sources")
        
        // Animated activity Indicator to indicate network activity.
        activityIndicator.startAnimating()
                
        
    }
    
    // MARK: Navigation
    // Takes user to the Sources VC once download is complete
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? UINavigationController{
            
            if let destinationVC = destination.topViewController as? SourcesViewController{
                destinationVC.filteredSources = filteredSources
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Downlad Method
    // Method used to download Sources in this view.
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
                        guard let sourceData = json["sources"] as? [[String: Any]]
                        else{assertionFailure(); return}
                        
                        
                        for source in sourceData{
                            if let id = source["id"] as? String,
                               let name = source["name"] as? String,
                               let desc = source["description"] as? String,
                               let urlString = source["url"] as? String,
                               let category = source["category"] as? String{
                                
                                self.sources.append(Source(id: id, name: name, description: desc, urlString: urlString, category: category))
                                
                            }
                        }
                    }
                }
                catch{
                    print(error.localizedDescription)
                    assertionFailure();
                }
                
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.filterSources()
                    
                    // Once download is complete user is taken to the sources view.
                    self.performSegue(withIdentifier: "SegueToRootView", sender: self)

                }
                
                
            })
            
            // start the task
            task.resume()
        }
        
        
        
    }
    
    // MARK: Filter Method
    // Method to filter the sources
    func filterSources(){
        for source in sources{
            switch source.category {
            case "general":
                filteredSources[0].append(source)
            case "technology":
                filteredSources[1].append(source)
            case "sports":
                filteredSources[2].append(source)
            case "business":
                filteredSources[3].append(source)
            case "entertainment":
                filteredSources[4].append(source)
            case "science":
                filteredSources[5].append(source)
            default:
                print("Error")
            }
        }
    }
    
    
}

