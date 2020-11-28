//
//  PetProfileDetailFooterSecondCell.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/25.
//

import UIKit

class PetProfileDetailFooterSecondCell: UICollectionViewCell {
    
    // MARK: Properties
    
    var dailyInfo:DailyInfoModel? {
        didSet {
            
            guard let dailyInfo = self.dailyInfo else { return }
            titleLabel.text = dailyInfo.title
            textLabel.text = dailyInfo.text
        }
    }
    
    private lazy var testLabel:UILabel = {
        let label = UILabel()
        label.text = "준비중인 기능이에요"
        return label
    }()
    
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        return label
    }()
    
    private lazy var textLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
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
        
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50).isActive = true
        
        addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        textLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        textLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        
    }
    
    
}
