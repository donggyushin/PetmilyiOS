//
//  FirstTab.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/10/25.
//

import UIKit

class FirstTabController: UIViewController {
    
    // MARK: - Properties
    private lazy var logoutButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("로그아웃", for: UIControl.State.normal)
        bt.addTarget(self, action: #selector(logout), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    // MARK: - Configures
    func configureUI() {
        clearNavigationBar()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: self.logoutButton)
        
        view.backgroundColor = .systemBackground
    }
    
    // MARK: - Selectors
    @objc func logout() {
        let root = Root.shared.root
        LocalData.shared.remove(key: "token")
        let authController = UINavigationController(rootViewController: LoginController())
        authController.modalPresentationStyle = .fullScreen
        root.present(authController, animated: true, completion: nil)
    }
    
}
