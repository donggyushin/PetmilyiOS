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
    // 최소 한개의 문자와 1개의 숫자 그리고 한개의 특수문자로 이루어진 8자 이상, 20자 이하
    public static let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,20}$"
    // 한글로 2자이상 5자이하
    public static let nicknameRegex = "^[가-힣//s]{2,5}$"
    // 최소 한개 이상의 문자와 길이는 8자 이상 20자 이하
    public static let userIdRegex = "(?i)^(?=.*[a-z])[a-z0-9]{8,20}$"
}
