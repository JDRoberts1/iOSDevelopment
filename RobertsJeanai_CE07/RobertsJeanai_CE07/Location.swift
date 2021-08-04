//
//  Location.swift
//  RobertsJeanai_CE07
//
//  Created by Nai Roberts on 7/24/21.
//

import Foundation

class Location{
    
    // Stored properties
    let city: String
    let location: [Double]
    let population: Int32
    let state: String
    let id: String
    
    // initializers
    init(city: String, location: [Double], population: Int32, state: String, id: String) {
        self.city = city
        self.location = location
        self.population = population
        self.state = state
        self.id = id
    }
}
