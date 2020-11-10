//
//  PetImageCell.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/08.
//

import UIKit
import SDWebImage


class PetImageCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    
    var photo:PetPhoto? {
        didSet {
            guard let photo = self.photo else { return }
            if let url = URL(string: photo.url) {
                self.photoView.sd_setImage(with: url, completed: nil)
            }
            if photo.favorite {
                self.star.isHidden = false
            }else {
                self.star.isHidden = true
            }
        }
    }
    
    private lazy var photoView:UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .secondarySystemGroupedBackground
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private lazy var star:UIImageView = {
        let iv = UIImageView()
        iv.widthAnchor.constraint(equalToConstant: 30).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 30).isActive = true
        iv.backgroundColor = .systemYellow
        return iv
    }()
    
    
    // MARK: - Lifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    func configureUI() {
        backgroundColor = .systemBackground
        
        addSubview(photoView)
        photoView.translatesAutoresizingMaskIntoConstraints = false
        photoView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        photoView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        photoView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        photoView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addSubview(star)
        star.translatesAutoresizingMaskIntoConstraints = false
        star.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        star.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        star.isHidden = true
        
    }
    
    // MARK: Overrides
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.async {
            self.photoView.layer.opacity = 0.6
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.async {
            self.photoView.layer.opacity = 1
        }
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.async {
            self.photoView.layer.opacity = 1
        }
    }
    
  
}
