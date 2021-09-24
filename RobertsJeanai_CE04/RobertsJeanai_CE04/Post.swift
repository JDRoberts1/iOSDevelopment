//  Jeanai Roberts
//  C202108 01
//  Code Exercise 04
//
//  Post.swift
//  RobertsJeanai_CE04
//
//

import Foundation
import UIKit

enum ParsingError: Error{
    case PostParsing
    case Generic
}

class Post{
    
    // stored properties
    let title: String
    let author: String
    var tImage: UIImage! = nil

    
    // initializer
    init(redditPost post: [String: Any]) throws {
        guard let title = post["title"] as? String,
              let author = post["author_fullname"] as? String,
              let tString = post["thumbnail"] as? String
              
        
        else{throw ParsingError.PostParsing }
        
        self.title = title
        self.author = author
        
        
        if tString.contains("http"),
           let url = URL(string: tString),
           var urlComp = URLComponents(url: url, resolvingAgainstBaseURL: false){
            
            urlComp.scheme = "https"
            
            if let secureUrl = urlComp.url{
                let imageData = try Data.init(contentsOf: secureUrl)
                self.tImage = UIImage(data: imageData)
            }
        }
        
    }
    
}
