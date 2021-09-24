//
//  Store.swift
//  RobertsJeanaiCE06
//
//  Created by Nai Roberts on 7/21/21.
//

import Foundation

class Store{
    
    // Stored Properties
    let storeName: String
    var storeItems: [StoreItem]!
    
    // Computed Properties
    var coutOfItems: Int{
        
        return storeItems.count
    }
    
    
    
    // Initializer
    init(storeName: String, storeItems: [StoreItem]? = nil) {
        self.storeName = storeName
        self.storeItems = storeItems
    }
}
