//
//  PetProfileDetailFooterSecondCell.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/25.
//

import UIKit

class PetProfileDetailFooterSecondCell: UICollectionViewCell {
    
    // MARK: Properties
    private lazy var testLabel:UILabel = {
        let label = UILabel()
        label.text = "준비중인 기능이에요"
        return label
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
    func configureUI() {
        backgroundColor = .systemBackground
        addSubview(testLabel)
        testLabel.translatesAutoresizingMaskIntoConstraints = false
        testLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        testLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
    
}
