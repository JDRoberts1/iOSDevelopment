//
//  Article.swift
//  RobertsJeanai09
//
//  Created by Nai Roberts on 8/27/21.
//

import Foundation
import UIKit


class Article{
    
    // Stored Properties
    let imgURL: String!
    let url: String
    let title: String
    let desc: String
    let author: String
    let publishedDate: String
    var img: UIImage!
    
    
    
    init(imgURL: String = "", img: UIImage! = nil, url: String, title: String, desc: String, author: String, publishedDate: String) {
        self.imgURL = imgURL
        self.url = url
        self.title = title
        self.desc = desc
        self.author = author
        self.publishedDate = publishedDate
        self.img = img
    }
    
}
