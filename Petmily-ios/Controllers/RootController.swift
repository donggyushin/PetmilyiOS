//
//  RootController.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/10/25.
//

import UIKit
import Firebase
import UserNotificationsUI

class RootController: UITabBarController {
    // MARK: - Properties
    private lazy var loadingView:LoadingView = {
        let lv = LoadingView()
        return lv
    }()
    
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
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loadingView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        loadingView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        loadingView.isHidden = true
    }
    
    func configureTabBar() {
        
        loadingView.isHidden = false
        
        let PresaleOfAnimals = UINavigationController(rootViewController: PresaleOfAnimalsController())
        let LostAnimals = UINavigationController(rootViewController: LostAnimalsController())
        let Pet = UINavigationController(rootViewController: PetController())
        let Chat = UINavigationController(rootViewController: ChatController())
        let My = UINavigationController(rootViewController: MeController())
        
        PresaleOfAnimals.tabBarItem.image = #imageLiteral(resourceName: "icons8-dog-house-100 1")
        
        LostAnimals.tabBarItem.image = #imageLiteral(resourceName: "icons8-search-100 1")
        
        Pet.tabBarItem.image = #imageLiteral(resourceName: "icons8-pet-commands-summon-100 1")
        
        Chat.tabBarItem.image = #imageLiteral(resourceName: "icons8-chat-bubble-100 1")
        
        My.tabBarItem.image = #imageLiteral(resourceName: "icons8-info-50 1")
        
        viewControllers = [PresaleOfAnimals, Pet,  Chat, My]
        
        loadingView.isHidden = true
        
    }
    
    
    
    
    // MARK: Helpers
    func receiveInfoFromPushNotification(info:[AnyHashable : Any]) {
        print(info)
    }
    
    
    func logout() {
        LocalData.shared.remove(key: "token")
        let loginController = UINavigationController(rootViewController: LoginController())
        loginController.modalPresentationStyle = .fullScreen
        self.viewControllers = []
        self.present(loginController, animated: true, completion: nil)
        
    }
    
    func checkUserLoggedIn() {
        
        
        LocalData.shared.getting(key: "token") { (token) in
                
            
            
            if let token = token {
                // 로그인이 되어져 있음.
                print("token: \(token)")
                if let fcm = Messaging.messaging().fcmToken {
                    print("fcm: \(fcm)")
                    UserService.shared.setUserFcmToken(fcm: fcm) { (error, errorMessage, success) in
                        print("fcm 저장 결과: \(success)")
                    }
                }
                
                // TODO: - 로그인 할때, fcmToken을 user db에 저장해준다.
                Properties.token = token
                self.configureTabBar()
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

