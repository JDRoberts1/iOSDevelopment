//
//  SemesterClass.swift
//  RobertsJeanaiCE01
//
//  Created by Nai Roberts on 7/2/21.
//

import Foundation

class SemesterClass{
    
    /* Stored Properties */
    let className: String
    let classID: Int
    let classFull: Bool
    let studentNames: [String]
    
    /* Computed Properties */
    var fullClassInfo : String{
        get{return "\(className)\(classID)"}
    }
    
    var classCount : Int{
        get{return studentNames.count}
    }
    
    /* Initializers */
    init(className: String, classID: Int, classFull: Bool, studentNames: [String]) {
        self.className = className
        self.classID = classID
        self.classFull = classFull
        self.studentNames = studentNames
    }
    
    /* Methods */
    func displaySeatsLeft(){
        let totalSeatsLeft = 10 - studentNames.count
        
        print("There are \(totalSeatsLeft) seats until this class is full ")
        
    }
    
}
