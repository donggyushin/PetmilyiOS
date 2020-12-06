//
//  NaverAddressModel.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/12/06.
//

import Foundation

struct NaverAddressModel {
    var title:String
    var link:String
    var category:String
    var description:String
    var telephone:String
    var address:String
    var roadAddress:String
    var mapx:String
    var mapy:String
    
    init(dict:[String:Any]) {
        var title = dict["title"] as? String ?? ""
        title = title.replacingOccurrences(of: "<b>", with: "")
        title = title.replacingOccurrences(of: "</b>", with: "")
        let link = dict["link"] as? String ?? ""
        let category = dict["category"] as? String ?? ""
        let description = dict["description"] as? String ?? ""
        let telephone = dict["telephone"] as? String ?? ""
        let address = dict["address"] as? String ?? ""
        let roadAddress = dict["roadAddress"] as? String ?? ""
        let mapx = dict["mapx"] as? String ?? ""
        let mapy = dict["mapy"] as? String ?? ""
        
        self.title = title
        self.link = link
        self.category = category
        self.description = description
        self.telephone = telephone
        self.address = address
        self.roadAddress = roadAddress
        self.mapx = mapx
        self.mapy = mapy
    }
    
}
