//
//  InputBoxView.swift
//  Rule 248
//
//  Created by Bryce Chan on 7/11/2023.
//

import UIKit

final class InputBoxView: UIView {

    let numberTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.textColor = .black
        textField.keyboardType = .decimalPad
        textField.font = .systemFont(ofSize: 18, weight: .bold)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .clear
        layer.borderWidth = 2
        layer.borderColor = UIColor.darkGray.cgColor
        layer.cornerRadius = Constants.inputBoxCornerRadius
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupSubviews() {
        addSubviews(numberTextField)
        
        NSLayoutConstraint.activate([
            numberTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            numberTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
            numberTextField.widthAnchor.constraint(equalTo: widthAnchor),
            numberTextField.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
        
}

