//
//  Legislator.swift
//  RobertsJeanaiCE05
//
//  Created by Nai Roberts on 7/18/21.
//

import Foundation
import UIKit

enum ParsingError: Error{
    case PostParsing
    case Generic
}

class Legislator{
    
    // stored properties
    let id: String
    let title : String
    let firstName: String
    let lastName: String
    let party: Character
    let state: String
    var legisImage: UIImage! = nil
    
    // computed properties
    var fullName: String{
        return lastName + "," + firstName
    }
    
    var partyId: String{
        return "\(party)" + "-" + state
    }
    
    init(legislatorPost post: [String: Any]) throws {
        guard let id = post["id"] as? String,
        let title = post["title"] as? String,
        let firstName = post["first_name"] as? String,
        let lastName = post["last_name"] as? String,
        let party = post["party"] as? Character,
        let state = post["state"] as? String
        else{throw ParsingError.PostParsing}
        
        self.id = id
        self.title = title
        self.firstName = firstName
        self.lastName = lastName
        self.party = party
        self.state = state
        
        let imgString = "https://theunitedstates.io/images/congress/225x275/" + id + ".jpg"
        
        if imgString.contains("http"),
           let imgUrl = URL(string: imgString),
           var urlComp = URLComponents(url: imgUrl, resolvingAgainstBaseURL: false){
            urlComp.scheme = "https"
            
            if let validURL = urlComp.url{
                let imageData = try Data.init(contentsOf: validURL)
                self.legisImage = UIImage(data: imageData)
            }
        }
    }
    
    
}
