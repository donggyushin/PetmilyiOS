//
//  MeController.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/12/05.
//

import UIKit

class MeController: UIViewController {

    // MARK: Properties
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.text = "My"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    // MARK: Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureUI()
        configureNav()
    }
    
    // MARK: Configures
    func configureNav() {
        clearNavigationBar()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
    }
    

}
