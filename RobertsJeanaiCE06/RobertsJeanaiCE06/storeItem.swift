//
//  storeItem.swift
//  RobertsJeanaiCE06
//
//  Created by Nai Roberts on 8/18/21.
//

import Foundation

class StoreItem{
    
    var item: String
    var isPurchased: Bool!
    
    
    
    init(item: String, purchased: Bool? = false) {
        
        self.item = item
        self.isPurchased = purchased
        
    }
    
}
