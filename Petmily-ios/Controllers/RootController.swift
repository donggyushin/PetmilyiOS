//
//  RootController.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/10/25.
//

import UIKit

class RootController: UITabBarController {
    // MARK: - Properties
    
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureTabBar()
        checkUserLoggedIn()
    }
    
    // MARK: - Configures
    func configureUI(){
        
        view.backgroundColor = .systemBackground
    }
    
    func configureTabBar() {
        let firstNav = UINavigationController(rootViewController: FirstTabController())
        let secondNav = UINavigationController(rootViewController: SecondTabController())
        let thirdNav = UINavigationController(rootViewController: ThirdTabController())
        
        firstNav.tabBarItem.title = "일번"
        secondNav.tabBarItem.title = "이번"
        thirdNav.tabBarItem.title = "삼번"
        
        viewControllers = [firstNav, secondNav, thirdNav]
        
    }
    
    // MARK: Helpers
    
    func checkUserLoggedIn() {
        
        // 이후에 로그인이 되어져 있는지 되어져 있지 않은지 판별하는 코드를 추가해주어야 함.
        LocalData.shared.getting(key: "token") { (token) in
            if let token = token {
                // 로그인이 되어져 있음.
                Properties.token = token
            }else {
                // 로그인이 되어져 있지 않음.
                // 로그인 화면으로 쏴주기
                let loginController = UINavigationController(rootViewController: LoginController())
                loginController.modalPresentationStyle = .fullScreen
                DispatchQueue.main.async {
                    self.present(loginController, animated: true, completion: nil)
                }
            }
        }
        
        
    }
}
