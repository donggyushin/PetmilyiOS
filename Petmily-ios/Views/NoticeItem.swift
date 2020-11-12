//
//  NoticeItem.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/12.
//

import UIKit

protocol NoticeItemDelegate:class {
    func noticeItemTapped(sender:NoticeItem)
}

class NoticeItem: UIView {
    
    // MARK: Properties
    weak var delegate:NoticeItemDelegate?
    lazy var label:UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var switchButton:UISwitch = {
        let bt = UISwitch()
        bt.isOn = false
        bt.isUserInteractionEnabled = false
        return bt
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
        backgroundColor = .systemBackground
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        
        addSubview(switchButton)
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        switchButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        switchButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
    }
    
    // MARK: Overrides
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.opacity = 0.6
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.opacity = 1
        self.delegate?.noticeItemTapped(sender: self)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.opacity = 1
    }

}
