//
//  UserProfileView.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/12/06.
//

import UIKit
import SDWebImage

class UserProfileView: UIView {
    
    // MARK: Properties
    var user:UserModel? {
        didSet {
            guard let user = self.user else { return }
            if user.profileImage != nil {
                if let url = URL(string: user.profileImage!) {
                    self.profileImageView.sd_setImage(with: url, completed: nil)
                }
            }
            self.userName.text = user.nickname
            self.userId.text = user.userId
        }
    }
    
    private lazy var profileImageView:UIImageView = {
        let iv = UIImageView()
        iv.widthAnchor.constraint(equalToConstant: 60).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 60).isActive = true
        iv.layer.cornerRadius = 20
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        return iv
    }()
    
    private lazy var userName:UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var userId:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
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
        
        addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        
        
        addSubview(userName)
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.topAnchor.constraint(equalTo: profileImageView.topAnchor, constant: 10).isActive = true
        userName.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 10).isActive = true
        
        addSubview(userId)
        userId.translatesAutoresizingMaskIntoConstraints = false
        userId.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 6).isActive = true
        userId.leftAnchor.constraint(equalTo: userName.leftAnchor).isActive = true
    }
    
}
