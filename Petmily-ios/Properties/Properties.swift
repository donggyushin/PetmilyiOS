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
    // 최소 1개의 숫자 혹은 특수 문자를 포함해야 함, 8자 이상 20자 이하
    public static let passwordRegex = "^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{8,20}$"
    // 한글로 2자이상 5자이하
    public static let nicknameRegex = "^[가-힣//s]{2,5}$"
    // 특수문자 사용 불가 8자 이상 20자 이하
    public static let userIdRegex = "^[a-zA-Z0-9]{8,20}$"
}
