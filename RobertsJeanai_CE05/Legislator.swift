//  Jeanai Roberts
//  C202107 01
//  Code Exercise 05
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
    let title : String!
    let firstName: String
    let lastName: String
    let party: String
    let state: String
    var legisImage: String
    
    // computed properties
    var fullName: String{
        return lastName + "," + firstName
    }
    
    var partyId: String{
        return "\(party)" + "-" + state
    }
    
    init(id: String, title: String? = nil, firstName: String, lastName: String, party: String, state: String) {
        self.id = id
        self.title = title
        self.firstName = firstName
        self.lastName = lastName
        self.party = party
        self.state = state
        
        let imgString = "https://theunitedstates.io/images/congress/225x275/" + id + ".jpg"
        
        self.legisImage = imgString
        
    }
    
    
}
