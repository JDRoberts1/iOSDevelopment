//
//  VCExtension.swift
//  RobertsJeanaiCE07
//
//  Created by Nai Roberts on 7/24/21.
//

import Foundation
import UIKit

extension ViewController{
    
    func parseAndDownload(jsonObject: [Any]?){
        guard let json = jsonObject
        else{assertionFailure("Parse failed at JSON"); return}
        
        for obj in json{
            guard let object = obj as? [String: Any],
                  let city = object["city"] as? String,
                  let location = object["loc"] as? [Double],
                  let population = object["pop"] as? Int32,
                  let state = object["state"] as? String,
                  let id = object["_id"] as? String
            else{assertionFailure("Parse failed at JSON"); return}
            
            zipcodes.append(Location(city: city, location: location, population: population, state: state, id: id))
                  
        }
        
    }
    
    
}
