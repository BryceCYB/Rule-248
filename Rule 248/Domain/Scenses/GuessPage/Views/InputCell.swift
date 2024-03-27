//
//  InputCell.swift
//  Rule 248
//
//  Created by Bryce Chan on 7/11/2023.
//

import UIKit

final class InputCell: UIView {
    
     let checkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Check", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = Constants.inputBoxCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let inputBoxOne = InputBoxView()
    let inputBoxTwo = InputBoxView()
    let inputBoxThree = InputBoxView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        alpha = 0.9
        backgroundColor = .lightGray
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func setupSubviews() {
        addSubview(containerView)
        containerView.addSubviews(inputBoxOne, inputBoxTwo, inputBoxThree, checkButton)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.widthAnchor.constraint(equalTo: widthAnchor, constant: -36),
            containerView.heightAnchor.constraint(equalTo: heightAnchor),
            
            inputBoxOne.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            inputBoxOne.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            inputBoxOne.widthAnchor.constraint(equalToConstant: Constants.numberBoxWidth),
            inputBoxOne.heightAnchor.constraint(equalToConstant: Constants.numberBoxHeight),
            
            inputBoxTwo.leftAnchor.constraint(equalTo: inputBoxOne.rightAnchor, constant: 12),
            inputBoxTwo.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            inputBoxTwo.widthAnchor.constraint(equalToConstant: Constants.numberBoxWidth),
            inputBoxTwo.heightAnchor.constraint(equalToConstant: Constants.numberBoxHeight),
            
            inputBoxThree.leftAnchor.constraint(equalTo: inputBoxTwo.rightAnchor, constant: 12),
            inputBoxThree.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            inputBoxThree.widthAnchor.constraint(equalToConstant: Constants.numberBoxWidth),
            inputBoxThree.heightAnchor.constraint(equalToConstant: Constants.numberBoxHeight),
            
            checkButton.leftAnchor.constraint(equalTo: inputBoxThree.rightAnchor, constant: 12),
            checkButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            checkButton.widthAnchor.constraint(equalToConstant: Constants.numberBoxWidth),
            checkButton.heightAnchor.constraint(equalToConstant: Constants.numberBoxHeight),
        ])
    }
        
}
