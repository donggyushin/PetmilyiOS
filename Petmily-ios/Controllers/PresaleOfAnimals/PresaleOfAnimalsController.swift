//
//  PresaleOfAnimalsController.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/10/31.
//

import UIKit

class PresaleOfAnimalsController:UIViewController {
    
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
