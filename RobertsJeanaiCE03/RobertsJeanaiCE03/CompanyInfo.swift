//
//  CompanyInfo.swift
//  RobertsJeanaiCE03
//
//  Created by Nai Roberts on 8/3/21.
//

import Foundation

class CompanyInfo{
    
    // Stored properties
    let catchPhrase: String
    var colors: [[String]]!
    let dailyRevenue: String
    
    init(catchPhrase: String, colors: [[String]]? = nil, dailyRevenue: String) {
        self.catchPhrase = catchPhrase
        self.colors = colors
        self.dailyRevenue = dailyRevenue
    }
}
