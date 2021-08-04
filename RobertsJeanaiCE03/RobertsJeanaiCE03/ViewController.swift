//
//  ViewController.swift
//  RobertsJeanaiCE03
//
//  Created by Nai Roberts on 7/6/21.
//

import UIKit

class ViewController: UIViewController {
    
    var companies = [Company]()
    var companyDetails = [CompanyInfo]()
    var companyDictonary : [[String]: [String]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        DwnldJSON(url: "https://fullsailmobile.firebaseio.com/T1NVC.json")
        DwnldJSON(url: "https://fullsailmobile.firebaseio.com/T2CRC.json")
        
        
    }
    
    // MARK: Retrieve JSON Data Method
    func DwnldJSON(url: String){
        
        let config = URLSessionConfiguration.default
        
        // Create session
        let session = URLSession(configuration: config)
        
        // Validate URL
        if let validURL = URL(string: url){
            let task = session.dataTask(with: validURL, completionHandler: { (data, response, error) in
                
                if let error = error{
                    
                    print("Data task failed due to: \(error.localizedDescription)")
                    return
                }
                
                print("Download successful")
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                      let validData = data
                else{print("Json Object creation failed"); return}
                
                do{
                    let jsonObj = try JSONSerialization.jsonObject(with: validData, options: .mutableContainers) as? [Any]
                    
                    // call parse method
                    self.ParseJson(jsonObj: jsonObj)
                }
                catch{
                    print(error.localizedDescription)
                }
                
            })
            // Start the task
            task.resume()
            
        }
        
    }
    
    // MARK: Parse JSON Object Method
    func ParseJson(jsonObj: [Any]?){
        
        guard let json = jsonObj
        else {print("Parse failed to unwrap the object"); return}
        
        for firstLevelObject in json{
            if let object = firstLevelObject as? [String: Any]{
                if let company = object["company"] as? String,
                   let name = object["name"] as? String,
                   let version = object["version"] as? String{
                    companies.append(Company(company: company, name: name, version: version))
                } else {
                    if let catchPhrase = object["catch_phrase"] as? String,
                              let colors = object["colors"] as? [[String]],
                              let dailyRevenue = object["daily_revene"] as? String{
                        
                        companyDetails.append(CompanyInfo(catchPhrase: catchPhrase, colors: colors, dailyRevenue: dailyRevenue))
                        
                    }
                }
                
                for c in companies{
                    for cd in companyDetails{
                        if cd.colors != nil{
                            c.companyDetails.append(CompanyInfo(catchPhrase: cd.catchPhrase, colors: cd.colors, dailyRevenue: cd.dailyRevenue))
                        }
                        else{
                            c.companyDetails.append(CompanyInfo(catchPhrase: cd.catchPhrase, dailyRevenue: cd.dailyRevenue))
                        }
                    }
                }
                
                
            }
        }
        
        print(companies.count)
    }
    
    
}

