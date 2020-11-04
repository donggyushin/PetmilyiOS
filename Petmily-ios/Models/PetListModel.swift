//
//  PetListModel.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/05.
//

import Foundation

struct Price {
    var min:String
    var max:String
}

struct PetListModel {
    var petSort:String?
    var name:String
    var life:String?
    var personality:[String]?
    var kind:[String]?
    var price:Price?
    var photourl:String?
    var description:String?
    
    init(dictionary:[String:AnyObject]) {
        let petSort = dictionary["petSort"] as? String
        let name = dictionary["name"] as? String ?? ""
        let life = dictionary["life"] as? String
        let personality = dictionary["personality"] as? [String]
        let kind = dictionary["kind"] as? [String]
        let priceDictionary = dictionary["price"] as? [String:AnyObject]
        if let priceDictionary = priceDictionary {
            let min = priceDictionary["min"] as? String ?? ""
            let max = priceDictionary["max"] as? String ?? ""
            let price = Price(min: min, max: max)
            self.price = price
        }
        let photourl = dictionary["photourl"] as? String
        let description = dictionary["description"] as? String
        
        self.personality = personality
        self.petSort = petSort
        self.name = name
        self.life = life
        self.kind = kind
        self.photourl = photourl
        self.description = description
    }
}
