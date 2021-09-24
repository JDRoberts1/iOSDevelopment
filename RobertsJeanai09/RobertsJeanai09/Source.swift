//
//  Source.swift
//  RobertsJeanai09
//
//  Created by Nai Roberts on 8/25/21.
//

import Foundation

class Source{
    
    let id: String
    let name: String
    let description: String
    let urlString: String
    let category: String
    
    init(id: String, name: String, description: String, urlString: String, category: String) {
        self.id = id
        self.name = name
        self.description = description
        self.urlString = urlString
        self.category = category
    }
}
