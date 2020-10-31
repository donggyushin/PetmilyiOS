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
        
        let PresaleOfAnimals = UINavigationController(rootViewController: PresaleOfAnimalsController())
        let LostAnimals = UINavigationController(rootViewController: LostAnimalsController())
        let Pet = UINavigationController(rootViewController: PetController())
        let Chat = UINavigationController(rootViewController: ChatController())
        
        
        
        PresaleOfAnimals.tabBarItem.title = "분양"
        PresaleOfAnimals.tabBarItem.image = #imageLiteral(resourceName: "icons8-dog-house-100 1")
        
        LostAnimals.tabBarItem.title = "찾기"
        LostAnimals.tabBarItem.image = #imageLiteral(resourceName: "icons8-search-100 1")
        
        Pet.tabBarItem.title = "반려"
        Pet.tabBarItem.image = #imageLiteral(resourceName: "icons8-pet-commands-summon-100 1")
        
        Chat.tabBarItem.title = "채팅"
        Chat.tabBarItem.image = #imageLiteral(resourceName: "icons8-chat-bubble-100 1")
        
        viewControllers = [PresaleOfAnimals, LostAnimals, Pet, Chat]
        
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
