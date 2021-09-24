//
//  SettingsViewController.swift
//  RobertsJeanai09
//
//  Created by Nai Roberts on 8/25/21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var pinkBttn: UIButton!
    @IBOutlet weak var darkBttn: UIButton!
    @IBOutlet weak var lightBttn: UIButton!
    @IBOutlet weak var label: UILabel!
    
    var selectedTheme: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        navigationItem.title = "Settings"
    }
    
    // MARK: Button Action
    // When the user selects one of the themes the current view is changed to reflect the selection.
    @IBAction func themeBttn(_ sender: UIButton) {
        switch sender.tag {
        
        // Theme consists of background color and text color.
        case 0:
            view.backgroundColor = UIColor.systemPink
            label.textColor = UIColor.black
            pinkBttn.titleLabel?.tintColor = UIColor.black
            darkBttn.titleLabel?.tintColor = UIColor.black
            lightBttn.titleLabel?.tintColor = UIColor.black
            selectedTheme = sender.currentTitle
        case 1:
            view.backgroundColor = UIColor.gray
            label.textColor = UIColor.white
            pinkBttn.titleLabel?.tintColor = UIColor.white
            darkBttn.titleLabel?.tintColor = UIColor.white
            lightBttn.titleLabel?.tintColor = UIColor.white
            selectedTheme = sender.currentTitle
        case 2:
            view.backgroundColor = UIColor.darkGray
            label.textColor = UIColor.white
            pinkBttn.titleLabel?.tintColor = UIColor.white
            darkBttn.titleLabel?.tintColor = UIColor.white
            lightBttn.titleLabel?.tintColor = UIColor.white
            selectedTheme = sender.currentTitle
        default:
            view.backgroundColor = .white
            pinkBttn.backgroundColor = .systemBlue
            darkBttn.backgroundColor = .systemBlue
            lightBttn.backgroundColor = .systemBlue
        }
    }
    
    // MARK: Reset Button
    // Reset button changes the theme back to the apps original state.
    @IBAction func resetBttn(_ sender: Any) {
        view.backgroundColor = UIColor.white
        pinkBttn.titleLabel?.tintColor = .systemBlue
        darkBttn.titleLabel?.tintColor = .systemBlue
        lightBttn.titleLabel?.tintColor = .systemBlue
    }
    
    // MARK: Save Button
    // Save button save the current theme to userDefaults
    @IBAction func saveBttn(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
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
