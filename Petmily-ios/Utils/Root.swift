//
//  RootViewController.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/10/31.
//

import UIKit

class Root {
    static let shared = Root()
    let root = UIApplication.shared.windows.first!.rootViewController as! RootController
}
