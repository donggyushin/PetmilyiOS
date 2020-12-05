//
//  MeController.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/12/05.
//

import UIKit

protocol MeControllerDelegate:class {
    func logout()
}

class MeController: UIViewController {

    // MARK: Properties
    weak var delegate:MeControllerDelegate?
    
    var user:UserModel? {
        didSet {
            guard let user = self.user else { return }
            self.userProfileView.user = user
        }
    }
    
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.text = "My"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var scrollView:UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    
    private lazy var userProfileView:UserProfileView = {
        let view = UserProfileView()
        return view
    }()
    
    private lazy var grayLine:UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    private lazy var logoutButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("로그아웃", for: UIControl.State.normal)
        bt.setTitleColor(UIColor.systemRed, for: UIControl.State.normal)
        bt.addTarget(self, action: #selector(logoutButtonTapped), for: UIControl.Event.touchUpInside)
        return bt
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
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        scrollView.addSubview(userProfileView)
        userProfileView.translatesAutoresizingMaskIntoConstraints = false
        userProfileView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        userProfileView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        userProfileView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        userProfileView.heightAnchor.constraint(equalToConstant: 60).isActive = true 
        
        scrollView.addSubview(grayLine)
        grayLine.translatesAutoresizingMaskIntoConstraints = false
        grayLine.topAnchor.constraint(equalTo: userProfileView.bottomAnchor, constant: 10).isActive = true
        grayLine.leftAnchor.constraint(equalTo: userProfileView.leftAnchor).isActive = true
        grayLine.rightAnchor.constraint(equalTo: userProfileView.rightAnchor).isActive = true
        
        
        scrollView.addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.topAnchor.constraint(equalTo: grayLine.bottomAnchor, constant: 50).isActive = true
        logoutButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        
    }
    
    // MARK: Selectors
    @objc func logoutButtonTapped() {
        self.delegate?.logout()
    }
    

}
