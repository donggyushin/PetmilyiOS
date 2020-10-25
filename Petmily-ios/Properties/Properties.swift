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
    // Minimum 8 characters at least 1 Alphabet, 1 Number and 1 Special Character
    public static let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
    public static let nicknameRegex = "^[가-힣//s]{2,5}$"
}
