//
//  Employee.swift
//  RobertsJeanaiCE02
//
// Jeanai Roberts
// CE01
// 08/02/2021
// C202108
//

import Foundation

class Employee{
    
    /* Stored Properties */
    let employeeName: String
    let username: String
    let macaddress: String
    let currentTitle: String
    let skills: [String]! // Skills may be empty
    var previousEmployers: [EmployeeInfo]! // previous employers may be empty
    
    /* Computed Properties */
    
    // Count of Skills
    var skillCount: Int{
        return skills.count
    }
    
    var SkillsString: String{
        var skills = ""
        
        for skill in skills {
            skills += "\(skill) \r\n"
        }
        
        return skills
    }
    
    // Count of Previous Employers
    var previousEmployerCount: Int{
        return previousEmployers.count
    }
    
    /* Initializers */
    init(employeeName: String, username:  String, macaddress: String, currentTitle: String, skills: [String]? = nil, previousEmployers: [EmployeeInfo]? = nil) {
        self.employeeName = employeeName
        self.username = username
        self.macaddress = macaddress
        self.currentTitle = currentTitle
        self.skills = skills
        self.previousEmployers = previousEmployers
        
    }
    
    
    
        
            
        
    /* Methods */
    
    
    
}
