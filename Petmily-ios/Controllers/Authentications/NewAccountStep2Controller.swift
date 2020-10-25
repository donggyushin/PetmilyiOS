//
//  NewAccountStep2Controller.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/10/25.
//

import UIKit

class NewAccountStep2Controller: UIViewController {
    
    // MARK: - Properties
    let phoneNumber:String
    
    // MARK: - Lifecycles
    init(phoneNumber:String) {
        self.phoneNumber = phoneNumber
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNavigation()
    }
    
    // MARK: - Configures
    func configureUI() {
        view.backgroundColor = .systemBackground
    }
    
    func configureNavigation() {
        navigationItem.hidesBackButton = true
        clearNavigationBar()
    }
    
    
}
