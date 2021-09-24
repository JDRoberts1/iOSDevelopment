//
//  ViewController.swift
//  RobertsJeanaiCE03
//
// Jeanai Roberts
// CE03
// c202108

import UIKit

class ViewController: UIViewController {
    
    var companies = [Company]()
    var companyDetails = [CompanyInfo]()
    var index = 0
    
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var catchPhraseLabel: UILabel!
    @IBOutlet weak var dailyRevLabel: UILabel!
    
    @IBOutlet weak var Desc1: UILabel!
    @IBOutlet weak var desc2Label: UILabel!
    @IBOutlet weak var desc3Label: UILabel!
    @IBOutlet weak var desc4Label: UILabel!
    
    @IBOutlet weak var color1Label: UILabel!
    @IBOutlet weak var color2Label: UILabel!
    @IBOutlet weak var color3Label: UILabel!
    @IBOutlet weak var color4Label: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Download JSON data from URL's
        DwnldJSON(url: "https://fullsailmobile.firebaseio.com/T1NVC.json")
        DwnldJSON(url: "https://fullsailmobile.firebaseio.com/T2CRC.json")
        
    }
    
    
    // MARK: Download JSON Data Method
    // Method used to download the JSON data grom given URL strings
    func DwnldJSON(url: String){
        
        // Create the configuration
        let config = URLSessionConfiguration.default
        
        // Create session
        let session = URLSession(configuration: config)
        
        // Validate URL
        if let validURL = URL(string: url){
            let task = session.dataTask(with: validURL, completionHandler: { (data, response, error) in
                
                // If error is present print the error
                if let error = error{
                    
                    print("Data task failed due to: \(error.localizedDescription)")
                    return
                }
                
                // Check response
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                      let validData = data
                else{print("Json Object creation failed"); return}
                
                do{
                    
                    // Create object
                    let jsonObj = try JSONSerialization.jsonObject(with: validData, options: .mutableContainers) as? [Any]
                    
                    // Parse object
                    self.ParseJson(jsonObj: jsonObj)
                    
                    // Check both arrays are complete before displaying object
                    // Note to self: (how to fix index out of range error)
                    if self.companyDetails.count == self.companies.count{
                        self.DisplayObject()
                    }
                    
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
        
        // Loop through the first level object of each URL
        for firstLevelObject in json{
            
            // Parse for the first URL
            if let object = firstLevelObject as? [String: Any]{
                
                if let company = object["company"] as? String,
                   let name = object["name"] as? String,
                   let version = object["version"] as? String{
                    
                    companies.append(Company(company: company, name: name, version: version))
                }
                
                // Parse for the second URL
                if let catchPhrase = object["catch_phrase"] as? String,
                   let colors = object["colors"] as? [[String: Any]]
                {
                    var colorArray = [String : String]()
                    
                    for color in colors{
                        if let c = color["color"] as? String,
                           let d = color["desription"] as? String{
                            
                            colorArray[d] = c
                        }
                    }
                    
                    // Nil check for daily rev
                    if object["daily_revene"] as? String != ""{
                        let dailyRevenue = object["daily_revene"] as? String
                        companyDetails.append(CompanyInfo(catchPhrase: catchPhrase, colors: colorArray ,dailyRevenue: dailyRevenue))
                    } else{
                        companyDetails.append(CompanyInfo(catchPhrase: catchPhrase, colors: colorArray))
                    }
                    
                }
                
            }
            
        }
        
    }
    
    // MARK: Display Method
    // Method used to display data on UI
    func DisplayObject(){
        DispatchQueue.main.async { [self] in
            
            companyLabel.text = companies[index].company.description
            nameLabel.text = companies[index].name.description
            versionLabel.text = companies[index].version.description
            if companyDetails[index].dailyRevenue != nil{
                dailyRevLabel.text = companyDetails[index].dailyRevenue.description
            } else{
                dailyRevLabel.text = "Not available"
            }
            catchPhraseLabel.text = companyDetails[index].catchPhrase.description
            
            let colors = self.companyDetails[self.index].colors
            
        
            for c in colors.keys{
                let i = colors.index(forKey: c)
                
                // If check to determine how many labels to display
                if c == "primary" {
                    self.color1Label.text = "primary"
                    self.Desc1.text = colors[i!].value.description
                } else if c == "secondary" {
                    self.color2Label.isHidden = false
                    self.desc2Label.isHidden = false
                    self.color2Label.text = "secondary"
                    self.desc2Label.text = colors[i!].value.description
                } else if c == "tertiary" {
                    self.color3Label.isHidden = false
                    self.desc3Label.isHidden = false
                    self.color3Label.text = "tertiary"
                    self.desc3Label.text = colors[i!].value.description
                } else if c == "quaternary" {
                    self.color4Label.isHidden = false
                    self.desc4Label.isHidden = false
                    self.color4Label.text = "quaternary"
                    self.desc4Label.text = colors[i!].value.description
                }
                
            }
            
        }
        
    }
    
    // MARK: Buttin Action
    // IBAction used to cycle through the data using the "Next" and "Previous" buttons
    @IBAction func CurrentCompanyChanged(_ sender: UIButton){
        
        // Update index back on button tag
        index += sender.tag
        
        if index < 0{
            // If the index is at the first object make previous button go to the last object
            index = companies.count - 1
        }
        else if index >= companies.count{
            // If the index is at the end of the objects make next button go to the first object
            index = 0
        }
        
        // Hide all labels
        self.color2Label.isHidden = true
        self.desc2Label.isHidden = true
        self.color3Label.isHidden = true
        self.desc3Label.isHidden = true
        self.color4Label.isHidden = true
        self.desc4Label.isHidden = true
        
        // Display new object
        DisplayObject()
    }
    
}

