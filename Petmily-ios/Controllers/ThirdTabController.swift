//
//  ThirdTabController.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/10/25.
//

import UIKit

class ThirdTabController:UIViewController {
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    // MARK: - Configures
    func configureUI() {
        clearNavigationBar()
        view.backgroundColor = .systemBackground
    }
}
