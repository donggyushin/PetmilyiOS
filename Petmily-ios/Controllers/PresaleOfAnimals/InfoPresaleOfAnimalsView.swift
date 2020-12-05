//
//  InfoPresaleOfAnimalsView.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/12/05.
//

import UIKit

protocol InfoPresaleOfAnimalsViewProtocol:class {
    func okayButtonTapped()
}

class InfoPresaleOfAnimalsView: UIViewController {
    
    // MARK: Properties
    weak var delegate:InfoPresaleOfAnimalsViewProtocol?
    
    private lazy var scrollView:UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    
    private lazy var titlaLabel:UILabel = {
        let label = UILabel()
        label.text = "동물 분양하기"
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.bold)
        return label
    }()
    
    private lazy var normalTextLabel:UILabel = {
        let label = UILabel()
        label.text = "펫밀리에서 동물 분양하기 뭔가 어떤 정보같은 것들을 여기서 설명을 "
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var okayButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("계속하기", for: UIControl.State.normal)
        bt.layer.borderWidth = 1
        bt.layer.cornerRadius = 6
        bt.layer.borderColor = UIColor.systemBlue.cgColor
        bt.addTarget(self, action: #selector(okayButtonTapped), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    private lazy var gobackButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("돌아가기", for: UIControl.State.normal)
        bt.layer.borderWidth = 1
        bt.layer.cornerRadius = 6
        bt.layer.borderColor = UIColor.systemBlue.cgColor
        bt.addTarget(self, action: #selector(gobackButtonTapped), for: UIControl.Event.touchUpInside)
        return bt
    }()

    // MARK: Lifecylces
    override func viewDidLoad() {
        configureUI()
    }
    
    // MARK: Configures
    func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.addSubview(titlaLabel)
        titlaLabel.translatesAutoresizingMaskIntoConstraints = false
        titlaLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 100).isActive = true
        titlaLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        scrollView.addSubview(normalTextLabel)
        normalTextLabel.translatesAutoresizingMaskIntoConstraints = false
        normalTextLabel.topAnchor.constraint(equalTo: titlaLabel.bottomAnchor, constant: 80).isActive = true
        normalTextLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        normalTextLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        
        scrollView.addSubview(okayButton)
        okayButton.translatesAutoresizingMaskIntoConstraints = false
        okayButton.topAnchor.constraint(equalTo: normalTextLabel.bottomAnchor, constant: 50).isActive = true
        okayButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        okayButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        okayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        scrollView.addSubview(gobackButton)
        gobackButton.translatesAutoresizingMaskIntoConstraints = false
        gobackButton.topAnchor.constraint(equalTo: okayButton.bottomAnchor, constant: 20).isActive = true
        gobackButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        gobackButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        gobackButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        gobackButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -100).isActive = true
    }
    
    // MARK: Selectors
    @objc func gobackButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func okayButtonTapped(){
        self.dismiss(animated: true) {
            self.delegate?.okayButtonTapped()
        }
    }

}
