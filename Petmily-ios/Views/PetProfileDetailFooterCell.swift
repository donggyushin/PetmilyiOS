//
//  PetProfileDetailFooterCell.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/08.
//

import UIKit

class PetProfileDetailFooterCell: UICollectionViewCell {
    
    // MARK: Properties
    private lazy var text:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "반려동물 사진을 업로드해보세요!\n언제든지 원할때 다운로드 받으실 수 있습니다 :)"
        return label
    }()
    
    lazy var card:TouchableUIView = {
        let view = TouchableUIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        view.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        view.addSubview(text)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        text.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        return view
    }()
    
    // MARK: Lifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configures
    func configureUI(){
        
        addSubview(card)
        card.translatesAutoresizingMaskIntoConstraints = false
        card.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        card.topAnchor.constraint(equalTo: topAnchor, constant: 100).isActive = true
        
    }
}

