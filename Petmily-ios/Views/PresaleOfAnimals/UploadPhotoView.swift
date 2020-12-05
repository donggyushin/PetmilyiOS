//
//  UploadPhotoView.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/12/05.
//

import UIKit

protocol UploadPhotoViewProtocol:class {
    func touched(sender:UploadPhotoView)
}

class UploadPhotoView: UIView {

    // MARK: Properties
    weak var delegate:UploadPhotoViewProtocol?
    
    private lazy var plusLabel:UILabel = {
        let label = UILabel()
        label.text = "+"
        label.font = UIFont.systemFont(ofSize: 40)
        return label
    }()
    
    private lazy var normalLabel:UILabel = {
        let label = UILabel()
        label.text = "탭 하여 반려동물의 사진을 업로드하세요"
        return label
    }()
    
    private lazy var textContainer:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [plusLabel, normalLabel])
        stack.axis = .vertical
        stack.alignment = .center
        return stack
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
        backgroundColor = .secondarySystemBackground
        layer.borderWidth = 1
        layer.cornerRadius = 6
        
        addSubview(textContainer)
        textContainer.translatesAutoresizingMaskIntoConstraints = false
        textContainer.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        textContainer.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    // MARK: Overrides
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.opacity = 0.6
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.opacity = 1
        self.delegate?.touched(sender: self)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.opacity = 1
    }
    
}
