//
//  RootController.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/10/25.
//

import UIKit
import Firebase
import UserNotificationsUI
import MapKit
import CoreLocation

class RootController: UITabBarController, MeControllerDelegate {
    // MARK: - Properties
    private lazy var loadingView:LoadingView = {
        let lv = LoadingView()
        return lv
    }()
    
    let locationManager:CLLocationManager = CLLocationManager()
    
    var user:UserModel? {
        didSet {
            guard let user = self.user else { return }
            guard let myNavigationController = self.viewControllers?[3] as? UINavigationController else { return }
            let myController = myNavigationController.viewControllers[0] as! MeController
            myController.user = user 
        }
    }
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        requestLocationToUser()
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
        
        let meController = My.viewControllers[0] as! MeController
        meController.delegate = self
        
        PresaleOfAnimals.tabBarItem.image = #imageLiteral(resourceName: "icons8-dog-house-100 1")
        
        LostAnimals.tabBarItem.image = #imageLiteral(resourceName: "icons8-search-100 1")
        
        Pet.tabBarItem.image = #imageLiteral(resourceName: "icons8-pet-commands-summon-100 1")
        
        Chat.tabBarItem.image = #imageLiteral(resourceName: "icons8-chat-bubble-100 1")
        
        My.tabBarItem.image = #imageLiteral(resourceName: "icons8-info-50 1")
        
        viewControllers = [PresaleOfAnimals, Pet,  Chat, My]
        self.selectedViewController = Pet
        
        loadingView.isHidden = true
        
        LocalData.shared.getting(key: "token") { (token) in
            guard let token = token else { return self.renderPopupWithOkayButtonNoImage(title: "에러", message: "로그인을 다시 해주세요.")}
            UserService.shared.getUserByToken(token: token) { (error, errorMessage, success, user) in
                if let errorMessage = errorMessage {
                    return self.renderPopupWithOkayButtonNoImage(title: "에러", message: errorMessage)
                }
                
                if let error = error {
                    return self.renderPopupWithOkayButtonNoImage(title: "에러", message: error.localizedDescription)
                }
                
                if success {
                    guard let user = user else { return }
                    self.user = user
                }else {
                    return self.renderPopupWithOkayButtonNoImage(title: "에러", message: "알 수 없는 에러 발생")
                }
            }
        }
        
    }
    
    
    
    
    // MARK: Helpers
    
    func requestLocationToUser () {
        print("Request Location")
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
    }
    
    
    
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


extension RootController:CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        Properties.locationLatitude = locValue.latitude
        Properties.locationLongitude = locValue.longitude
        
    }
}
