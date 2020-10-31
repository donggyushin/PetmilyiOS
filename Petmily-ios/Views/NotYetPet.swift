//
//  NotYetPet.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/10/31.
//

import UIKit

class NotYetPet:UIView {
    
    // MARK: - Properties
    private lazy var label:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "함께하는 반려동물이 있으신가요?\n반려동물을 새로 등혹하고 반려동물에 유익한 정보를 받아보세요"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Lifecycles
    init() {
        super.init(frame: CGRect.zero)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configures
    func configureUI() {
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 8
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40).isActive = true
        label.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
    }
}
