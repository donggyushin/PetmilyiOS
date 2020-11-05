//
//  Properties.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/10/25.
//

import Foundation

class Properties {
    public static var token:String?
    public static var PETMILY_API = "http://210.123.254.17:9042/api"
    // 최소 1개의 숫자 혹은 특수 문자를 포함해야 함, 8자 이상 20자 이하(서버)
    // 최소 1개의 영대문자. 1개의 특수문자, 2개이상의 숫자, 3개이상의 소문자 캐릭터. 8자 이상 20자 이하
    public static let passwordRegex = "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9].*[0-9])(?=.*[a-z].*[a-z].*[a-z]).{8,20}$"
    // 한글로 2자이상 5자이하
    public static let nicknameRegex = "^[가-힣//s]{2,5}$"
    
    public static let petnameRegex = "^[가-힣//s]{1,12}$"
    
    // 특수문자 사용 불가 8자 이상 20자 이하
    public static let userIdRegex = "^[a-zA-Z0-9]{8,20}$"
}
