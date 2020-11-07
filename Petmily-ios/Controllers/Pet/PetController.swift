//
//  PetController.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/10/31.
//

import UIKit

class PetController: UIViewController {
    

    // MARK: Properties
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.text = "반려"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var notYetView:NotYetPet = {
        let view = NotYetPet()
        view.delegate = self
        return view
    }()
    
    // MARK: - Lifecylces
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNavigation()
    
        
        
    }
    
    // MARK: - Configures
    func configureUI() {
        clearNavigationBar()
        
        view.backgroundColor = .systemBackground
        view.addSubview(notYetView)
        notYetView.translatesAutoresizingMaskIntoConstraints = false
        notYetView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        notYetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70).isActive = true
        notYetView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8).isActive = true
        notYetView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
    }
    
    func configureNavigation(){
        navigationItem.backButtonTitle = "반려"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        
    }
    
    
}

extension PetController:NotYetPetProtocol {
    func notYetViewTapped() {
        
        let petRegisterViewController = PetRegisterViewController()
        petRegisterViewController.delegate = self
        
        navigationController?.pushViewController(petRegisterViewController, animated: true)
    }
    
}

extension PetController:PetRegisterViewControllerDelegate {
    func registerDone() {
        print("반려동물 등록완료")
        // TODO: - 나중에 여기서 반려동물들을 호출하는 함수를 한 번 호출해줘야함!
    }
    
    
}
