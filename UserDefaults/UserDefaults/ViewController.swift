//
//  ViewController.swift
//  UserDefaults
//
//  Created by Nai Roberts on 8/23/21.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var colorTextField: UITextField!
    
    // Label Outlets
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    // slider Outlets
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        colorTextField.delegate = self
        
        // Set the sliders to 0
        for slider in [redSlider, blueSlider, greenSlider]{
            slider?.value = 0
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }

    @IBAction func saveBTNTapped(_ sender: Any) {
        
        // Access our standard set of UserDefaults, and save the text with a known key
        UserDefaults.standard.set(colorTextField.text, forKey: "colorText")
        
        // Save the current color via the extension method
        UserDefaults.standard.set(color: colorView.backgroundColor!, forKey: "viewColor")
        
        // Clear the text field
        colorTextField.text = ""
        
        // Clear the colorView
        // Reset the color view after saving
        colorView.backgroundColor = UIColor.black
    }
    
    @IBAction func loadBTNTapped(_ sender: Any) {
        // access saved default
        if let savedText = UserDefaults.standard.object(forKey: "colorText") as? String{
            colorTextField.text = savedText
        }
        
        // Load color from user defaults
        if let savedColor = UserDefaults.standard.color(forKey: "viewColor"){
            
            // Set background color to saved color 
            colorView.backgroundColor = savedColor
        }
    }
    
    @IBAction func sliderDidChange(_ sender: UISlider) {
        
        // Use a switch statement based on slider tag
        switch sender.tag {
        case 0:
            // red slider
            // update the label
            redLabel.text = sender.value.description
            
            
        case 1:
            // green slider
        greenLabel.text = sender.value.description
            
        case 3:
            // blue slider
            blueLabel.text = sender.value.description
            
            
        default:
            print("Should not be here")
        }
        
        // Update the colorViews view
        colorView.layer.backgroundColor = UIColor(displayP3Red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1).cgColor
    }
    
}

