//  Jeanai Roberts
//  C202108 01
//  Code Exercise 05
//
//  legislatorDetailsViewController.swift
//  RobertsJeanai_CE05
//
//

import UIKit

class legislatorDetailsViewController: UIViewController {

    var img: UIImage! = nil
    @IBOutlet weak var legislatorImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var party: UILabel!
    @IBOutlet weak var state: UILabel!
    
    var legislator: Legislator!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Check if object is empty
        if legislator != nil{
            
            // Update background color based on party
            ChangeColor(party: legislator.party)
            
            // Download legislator image
            convImg(imgString: legislator.legisImage)
            
            // Display Legislator Object
            name.text = legislator.fullName
            titleLabel.text = legislator.title
            party.text = legislator.party
            state.text = legislator.state
            navigationItem.title = legislator.fullName
        }
    }
    
    
    // Function to detemine background color
    func ChangeColor(party: String){
        switch party {
        case "D":
            self.view.backgroundColor = UIColor.blue
        case "R":
            self.view.backgroundColor = UIColor.red
        case "I":
            self.view.backgroundColor = UIColor.yellow
        default:
            self.view.backgroundColor = UIColor.white
        }
    }
    
    // Method to convert object image string to Image
    func convImg(imgString: String){
        
        if let url = URL(string: imgString){
            do{
                let img = try Data(contentsOf: url)
                self.img = UIImage(data: img)
            }
            catch{
                print(error.localizedDescription)
            }
        }
        
        legislatorImage.image = img
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
