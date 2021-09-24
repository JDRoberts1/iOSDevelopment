//
//  UserDefault_EXE.swift
//  UserDefaults
//
//  Created by Nai Roberts on 8/25/21.
//

import Foundation
import UIKit

extension UserDefaults{
    
    // Save UIColor as a data object
    func set(color: UIColor, forKey key: String){
        
        // convert the UIColor object into a data object by Archving
        let binaryObject = try? NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: true)
        
        // Save binary data to user defaults
        self.set(binaryObject, forKey: key)
    }
    
    // Get UIColor from saved defaults with key
    func color(forKey key: String) -> UIColor?{
        
        // Check for valid data
        if let binaryData = data(forKey: key){
            if let color = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: binaryData){
                
                // return the UIColor
                return color
            }
        }
        
        // If we do not return a UIColor, something is wrong with the data
        return nil
    }
}

