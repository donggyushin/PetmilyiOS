//
//  PetProfileImageViewController.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/08.
//

import UIKit

class PetProfileImageViewController: UIViewController {
    
    // MARK: - Properties
    let pet:PetModel
    
    private lazy var photo:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        if let url = URL(string: self.pet.photourl) {
            iv.sd_setImage(with: url, completed: nil)
        }
        return iv
    }()
    
    // MARK: - Lifecycles
    init(pet:PetModel) {
        self.pet = pet
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(photo)
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        photo.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    

}
