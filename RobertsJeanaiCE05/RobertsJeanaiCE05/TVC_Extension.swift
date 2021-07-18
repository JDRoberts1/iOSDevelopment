//  Jeanai Roberts
//  C202107 01
//  Code Exercise 05
//
//  TVC_Extension.swift
//  RobertsJeanaiCE05
//
//  Created by Nai Roberts on 7/17/21.
//

import Foundation

extension TableViewController{
    
    func downloadJson(atUrl urlString: String){
        
        // create default configuration
        let config = URLSessionConfiguration.default
        
        // create a session
        let session = URLSession(configuration: config)
        
        // validate the URL to ensure it is not a broken link
        if let validURL = URL(string: urlString){
            
            var request = URLRequest(url: validURL)
            
            request.setValue("9LtjIlWOqQ2urBlzJE2FQeD4Am6NTWphRoGVwIMD", forHTTPHeaderField: "X-API-Key")
            
            // type of request
            request.httpMethod = "GET"
            
            
            let task = session.dataTask(with: validURL, completionHandler: { (urlData, response, error) in
                
                // check if error is empty
                if error != nil {assertionFailure(); return}
                
                // check the response, statusCode, and data
                guard let response = response as? HTTPURLResponse, response.statusCode == 200, let data = urlData
                else {assertionFailure(); return}
                
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any]{
                        
                        guard let firstLevelObject = json["results"] as? [[String: Any]]
                        else{assertionFailure(); return}
                        
                        for object in firstLevelObject{
                            guard let member = object["member"] as? [String: Any]
                            else{assertionFailure(); return}
                            
                            do{
                                try self.legislators.append(Legislator(legislatorPost: member))
                            }
                            catch{
                                assertionFailure("Legislator could not be created")
                            }
                            
                        }
                    }
                }
                catch{
                    print(error.localizedDescription)
                    assertionFailure();
                }
                
                DispatchQueue.main.async {
                    self.filterByParty()
                    self.tableView.reloadData()
                }
                
            })
            
            task.resume()
        }
    }
    
    func filterByParty(){
        parties[0] = legislators.filter({$0.party == "D"})
        parties[1] = legislators.filter({$0.party == "R"})
        parties[2] = legislators.filter({$0.party == "I"})
    }
}
