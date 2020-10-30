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
    func renderAlertWhenUserFirstLoggedInAndDoentHaveAnyAnimalsRegistered() {
        let alert = UIAlertController(title: "팻밀리에 오신 걸 환영합니다", message: "현재 반려동물을 기르고 계신가요? 반려동물의 정보를 입력하면 유용한 정보에 대해서 받아보실 수 있으십니다. 기르고 계신 반려동물을 등록하시겠어요?", preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "네", style: .default, handler: { (action) in
            
            // 반려동물 기입 페이지로 이동시켜준다
            let animalRegister = UINavigationController(rootViewController: AnimalRegister1())
            animalRegister.modalPresentationStyle = .fullScreen
            self.present(animalRegister, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "아니요", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
    
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
