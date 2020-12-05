//
//  PresaleOfAnimalsController.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/10/31.
//

import UIKit

class PresaleOfAnimalsController:UIViewController {
    
    // MARK: Properties
    
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.text = "분양"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var postButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("분양하기", for: UIControl.State.normal)
        bt.addTarget(self, action: #selector(postButtonTapped), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    
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
        configureNav()
    }
    
    // MARK: - Configures
    func configureUI() {
        clearNavigationBar()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        
        view.backgroundColor = .systemBackground
        view.addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true 
    }
    
    func configureNav() {
        navigationItem.backButtonTitle = "분양"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: postButton)
    }
    
    // MARK: - Selectors
    @objc func logout() {
        Root.shared.root.logout()
    }
    
    @objc func postButtonTapped(){
        print("분양하기 버튼 클릭")
        let infoPresaleOfAnimals = InfoPresaleOfAnimalsView()
        infoPresaleOfAnimals.delegate = self
        infoPresaleOfAnimals.modalPresentationStyle = .fullScreen
        self.present(infoPresaleOfAnimals, animated: true, completion: nil)
    }
}


extension PresaleOfAnimalsController:InfoPresaleOfAnimalsViewProtocol {
    func okayButtonTapped() {
        print("okay button 클릭됨")
        let postPresaleFirstController = PostPresaleFirstController()
        navigationController?.pushViewController(postPresaleFirstController, animated: true)
    }
}
