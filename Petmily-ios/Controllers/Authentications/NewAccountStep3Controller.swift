//
//  NewAccountStep3Controller.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/10/25.
//

import UIKit

class NewAccountStep3Controller:UIViewController {
    
    // MARK: - Properties
    let userId:String
    let phoneNumber:String
    
    // MARK: - Lifecycles
    
    init(userId:String, phoneNumber:String) {
        self.userId = userId
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
        navigationItem.title = userId
    }
}
