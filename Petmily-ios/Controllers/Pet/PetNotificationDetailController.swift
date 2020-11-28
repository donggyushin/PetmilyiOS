//
//  PetNotificationDetailController.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/28.
//

import UIKit

class PetNotificationDetailController: UIViewController {

    // MARK: Properties
    private lazy var testLabel:UILabel = {
        let label = UILabel()
        label.text = "준비중인 페이지 입니다"
        return label
    }()
    
    
    // MARK: Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureUI()
    }
    
    // MARK: Configures
    func configureUI(){
        view.backgroundColor = .systemBackground
        
        view.addSubview(testLabel)
        testLabel.translatesAutoresizingMaskIntoConstraints = false
        testLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        testLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }

}
