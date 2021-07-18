//
//  ViewController.swift
//  RobertsJeanaiCE02
//
//  Created by Nai Roberts on 6/8/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var employeeNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var macAddressLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var skillsTextField: UITextView!
    @IBOutlet weak var pastEmployTextField: UITextView!
    @IBOutlet weak var pastEmployCount: UILabel!
    @IBOutlet weak var skillsCountLabel: UILabel!
    var employees = [Employee]()
    
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Create path to file
        if let path = Bundle.main.path(forResource: "EmployeeData", ofType: ".json"){
            
            // Create url with path
            let url = URL(fileURLWithPath: path)
            
            do{
                
                let data = try Data.init(contentsOf: url)
                
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Any]
                
                // Parse the JSON objects included in the file
                ParseJson(jsonObj: jsonObj)
                
                // Display objects after parsing is complete
                DisplayEmployee()
            }
            catch{
                
                print(error.localizedDescription)
            }
            
            
        }
    }
    
    // MARK: Parse Function
    // Function to parse JSOn objects
    func ParseJson(jsonObj: [Any]?){
        guard let json = jsonObj
        else {print("Parse failed to unwrap the Optional"); return}
        
        // Parse the first level object
        for firstLevelItem in json{
            
            guard  let object = firstLevelItem as? [String : Any ],
                   let employeeName = object["employeename"] as? String,
                   let userName = object["username"] as? String,
                   let macAddress = object["macaddress"] as? String,
                   let currentTitle = object["current_title"] as? String,
                   let skills = object["skills"] as? [String]
            
            else {continue}
            
            // MARK: Second Level Object Function
            // Nested function to parse the second level item in JSOn object
            func addPreviousWork(){
                
                if let secondLevelItem = object["past_employers"] as? [[String : Any]]{
                    
                    // If - Else statement to check if the second level object is null
                    if secondLevelItem.isEmpty != true{
                        var previous = [EmployeeInfo]()
                        // if the object is not nil add each of the the second level items to array created above
                        for employer in secondLevelItem{
                            if let company = employer["company"] as? String{
                                if let responsibilities = employer["responsibilities"] as? [String]{
                                    previous.append(EmployeeInfo(companyName: company, responsibilities: responsibilities))
                                }
                            }
                        }
                        
                        // Once complete add the newly created object
                        employees.append(Employee(employeeName: employeeName, username: userName, macaddress: macAddress, currentTitle: currentTitle, skills: skills, previousEmployers: previous))
                        
                        
                    }
                    // If the second level object is empty add nil array
                    else{
                        employees.append(Employee(employeeName: employeeName, username: userName, macaddress: macAddress, currentTitle: currentTitle, skills: skills, previousEmployers: nil))
                        
                    }
                }
                
            }
            
            addPreviousWork()
            
        }
        
        
        
    }
    
    // MARK: Display Function
    // Function to display parsed objects
    func DisplayEmployee(){
        employeeNameLabel.text = employees[currentIndex].employeeName.description
        
        usernameLabel.text = employees[currentIndex].username.description
        
        macAddressLabel.text = employees[currentIndex].macaddress.description
        
        jobTitleLabel.text = employees[currentIndex].currentTitle.description
        
        skillsCountLabel.text = employees[currentIndex].skillCount.description
        
        
        var skills = ""
        
        for skill in employees[currentIndex].skills {
            skills += "\(skill) \r\n"
        }
        
        if skills != ""{
            skillsTextField.text = skills
        } else{
            skillsTextField.text = "No Skills available"
        }
        
        
        if employees[currentIndex].previousEmployers != nil{
            var display = ""
            for employer in employees[currentIndex].previousEmployers{
                display += "\r\nCompany: \(employer.companyName.description) \r\nResponsibilities:"
                for r in employer.responsibilities{
                    display += "\(r) "
                }
            }
            
            pastEmployTextField.text = display
            pastEmployCount.text = employees[currentIndex].previousEmployerCount.description
        }
        else{
            pastEmployTextField.text = "Not available"
            pastEmployCount.text = "0"
        }
        
        
    }
    
    // MARK: Next & Prev Button
    // Action to change the object being displayed
    @IBAction func CurrentIndexChanged(_ sender: UIButton){
        currentIndex += sender.tag
        
        if currentIndex < 0{
            currentIndex = employees.count - 1
        } else if currentIndex >= employees.count{
            currentIndex = 0
        }
        
        DisplayEmployee()
    }
    
    
}

