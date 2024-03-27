//
//  OutputBoxView.swift
//  Rule 248
//
//  Created by Bryce Chan on 7/11/2023.
//

import UIKit

final class OutputBoxView: UIView {
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        backgroundColor = Constants.backgroundGreen
        layer.cornerRadius = Constants.inputBoxCornerRadius
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupSubviews() {
        addSubviews(numberLabel)
        
        NSLayoutConstraint.activate([
            numberLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            numberLabel.widthAnchor.constraint(equalTo: widthAnchor),
            numberLabel.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
        
}


