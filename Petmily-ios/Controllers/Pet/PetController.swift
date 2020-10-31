//
//  PetController.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/10/31.
//

import UIKit

class PetController: UIViewController {
    

    // MARK: Properties
    private lazy var notYetView:NotYetPet = {
        let view = NotYetPet()
        return view
    }()
    
    // MARK: - Lifecylces
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    
        
        
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
    
    
}
