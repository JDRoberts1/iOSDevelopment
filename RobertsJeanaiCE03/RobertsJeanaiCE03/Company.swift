//
//  Company.swift
//  RobertsJeanaiCE03
//
// Jeanai Roberts
// CE03
// c202108


import Foundation

class Company{
    
    // Stored properties
    let company: String
    let name: String
    let version : String
    var companyDetails : [CompanyInfo]!
    
    // Initalizers
    init(company: String, name: String, version: String, companyDetails: [CompanyInfo]? = nil) {
        self.company = company
        self.name = name
        self.version = version
        self.companyDetails = companyDetails
    }
    
    
    
    
}
