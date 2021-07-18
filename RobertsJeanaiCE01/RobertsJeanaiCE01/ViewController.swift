//
//  ViewController.swift
//  RobertsJeanaiCE01
//
//  Created by Nai Roberts on 7/2/21.
//

// Jeanai Roberts
// CE01
// 07/02/2021
// C202107



import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var fullClassInfo: UILabel!
    @IBOutlet weak var className: UILabel!
    @IBOutlet weak var classIDLabel: UITextField!
    @IBOutlet weak var classFullSwitch: UISwitch!
    @IBOutlet weak var classCountLabel: UILabel!
    @IBOutlet weak var studentsTextView: UITextView!
    
    // Array of Class objects
    var classes = [SemesterClass]()
    
    var currentClassIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // get path to file
        if let path = Bundle.main.path(forResource: "semesterClassList", ofType: ".json"){
            
            let url = URL(fileURLWithPath: path)
            
            do{
                let data = try Data.init(contentsOf: url)
                
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Any]
                
                // Parse the JSON file into objects
                ParseObj(jsonObject: jsonObj)
                
                // Display first object upon load
                displayCurrentClass()
                
            } catch{
                
                // Display error if file cannot be retrieved
                print(error.localizedDescription)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        // Dispose of any resources that can be created
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Parse JSON data
    // Function to Parse JSON
    func ParseObj(jsonObject: [Any]?){
        
        guard let json = jsonObject
        else {print("Parse failed to unwrap the optional"); return}
        
        // Loop through first level objects
        for firstLevelItem in json{
            
            guard let object = firstLevelItem as? [String : Any],
                  let className = object["class_name"] as? String,
                  let classId =  object["class_id"] as? Int,
                  let classFull =  object["class_full"] as? Bool,
                  let students =  object["student_names"] as? [String]
            else{return}
            
            // Create a new Class and append to the array
            classes.append(SemesterClass(className: className, classID: classId, classFull: classFull, studentNames: students))
        }
        
    }
    
    // MARK: Display JSON Objects
    func displayCurrentClass(){
        
        // Display object to UI elements
        fullClassInfo.text = classes[currentClassIndex].fullClassInfo.description
        
        className.text = classes[currentClassIndex].className.description
        
        classIDLabel.text = classes[currentClassIndex].classID.description
        
        if classes[currentClassIndex].classFull == true{
            classFullSwitch.isOn = true
        } else{
            classFullSwitch.isOn = false
        }
        
        classCountLabel.text = classes[currentClassIndex].classCount.description
        
        var students = ""
        for student in classes[currentClassIndex].studentNames{
            students += "\(student) \r\n"
            
        }
        
        studentsTextView.text = students
        
        
        
    }
    
    // MARK: Next & Previous Button
    // Button used to switch between JSON objects
    @IBAction func CurrentClassChanged(_ sender: UIButton){
        
        currentClassIndex += sender.tag
        
        if currentClassIndex < 0{
            currentClassIndex = classes.count - 1
        } else if currentClassIndex >= classes.count{
            currentClassIndex = 0
        }
        
        displayCurrentClass()
    }


}

