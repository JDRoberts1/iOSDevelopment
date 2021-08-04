//  Jeanai Roberts
//  C202107 01
//  Code Exercise 05
//
//  legislatorDetailsViewController.swift
//  RobertsJeanai_CE05
//
//  Created by Nai Roberts on 7/18/21.
//

import UIKit

class legislatorDetailsViewController: UIViewController {

    @IBOutlet weak var legislatorImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var party: UILabel!
    @IBOutlet weak var state: UILabel!
    
    var legislator: Legislator!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if legislator != nil{
            ChangeColor(party: legislator.party)
            if legislator.legisImage != nil{
                legislatorImage.image = legislator.legisImage
            }
            name.text = legislator.fullName
            titleLabel.text = legislator.title
            party.text = legislator.party
            state.text = legislator.state
            navigationItem.title = legislator.fullName
        }
    }
    
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
