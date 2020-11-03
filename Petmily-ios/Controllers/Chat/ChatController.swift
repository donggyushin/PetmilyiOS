//
//  ChatController.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/10/31.
//

import UIKit

class ChatController:UIViewController {
    
    // MARK: Properties
    
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.text = "채팅"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Configures
    func configureUI() {
        clearNavigationBar()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        
        view.backgroundColor = .systemBackground
    }
}
