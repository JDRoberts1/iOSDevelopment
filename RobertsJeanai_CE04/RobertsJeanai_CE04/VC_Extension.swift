//  Jeanai Roberts
//  C202108 01
//  Code Exercise 04
//
//  VC_Extension.swift
//  RobertsJeanai_CE04
//
//

import Foundation
import UIKit

extension ViewController{
    
    // Method to download and parse data
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
                        guard let outerData = json["data"] as? [String: Any],
                              let children = outerData["children"] as? [[String: Any]]
                        else{assertionFailure(); return}
                        
                        for child in children{
                            guard let post = child["data"] as? [String: Any]
                            else{assertionFailure(); return}
                            
                            if post["thumbnail"] as? String != "default"{
                                do{
                                    try self.posts.append(Post(redditPost: post))
                                }
                                catch{
                                    assertionFailure("Failed to create post")
                                }
                            }
                            
                            
                        }
                        
                    }
                }
                catch{
                    print(error.localizedDescription)
                    assertionFailure();
                }
                // add back to the main thread
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            })
            // start the task
            task.resume()
        }
        
        
        
    }
    
    
}
