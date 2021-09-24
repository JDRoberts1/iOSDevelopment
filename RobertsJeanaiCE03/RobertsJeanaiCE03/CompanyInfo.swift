//
//  CompanyInfo.swift
//  RobertsJeanaiCE03
//
// Jeanai Roberts
// CE03
// c202108


import Foundation

class CompanyInfo{
    
    // Stored properties
    let catchPhrase: String
    var colors: [String: String]
    let dailyRevenue: String!
    
    init(catchPhrase: String, colors: [String: String], dailyRevenue: String? = nil) {
        self.catchPhrase = catchPhrase
        self.colors = colors
        self.dailyRevenue = dailyRevenue
    }
}
