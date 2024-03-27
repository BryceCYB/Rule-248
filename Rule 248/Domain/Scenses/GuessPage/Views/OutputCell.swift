//
//  OutputCell.swift
//  Rule 248
//
//  Created by Bryce Chan on 7/11/2023.
//

import UIKit

final class OutputCell: UICollectionViewCell {
    
    static let identifier = "OutputCell"
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.backgroundGreen
        label.text = "Yes!"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = Constants.backgroundGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    private let outputBoxOne = OutputBoxView()
    private let outputBoxTwo = OutputBoxView()
    private let outputBoxThree = OutputBoxView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
//        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func setupSubviews() {
        addSubview(containerView)
        containerView.addSubviews(outputBoxOne, outputBoxTwo, outputBoxThree, resultLabel)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.widthAnchor.constraint(equalTo: widthAnchor, constant: -36),
            containerView.heightAnchor.constraint(equalTo: heightAnchor),
            
            outputBoxOne.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            outputBoxOne.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            outputBoxOne.widthAnchor.constraint(equalToConstant: Constants.numberBoxWidth),
            outputBoxOne.heightAnchor.constraint(equalToConstant: Constants.numberBoxHeight),
            
            outputBoxTwo.leftAnchor.constraint(equalTo: outputBoxOne.rightAnchor, constant: 12),
            outputBoxTwo.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            outputBoxTwo.widthAnchor.constraint(equalToConstant: Constants.numberBoxWidth),
            outputBoxTwo.heightAnchor.constraint(equalToConstant: Constants.numberBoxHeight),
            
            outputBoxThree.leftAnchor.constraint(equalTo: outputBoxTwo.rightAnchor, constant: 12),
            outputBoxThree.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            outputBoxThree.widthAnchor.constraint(equalToConstant: Constants.numberBoxWidth),
            outputBoxThree.heightAnchor.constraint(equalToConstant: Constants.numberBoxHeight),
            
            resultLabel.leftAnchor.constraint(equalTo: outputBoxThree.rightAnchor, constant: 18),
            resultLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            resultLabel.widthAnchor.constraint(equalToConstant: Constants.numberBoxWidth),
            resultLabel.heightAnchor.constraint(equalToConstant: Constants.numberBoxHeight),
        ])
        
        setupCell(withResult: GuessResult(numOne: 2, numTwo: 4, numThree: 8, pass: true))
    }
    
    func setupCell(withResult result: GuessResult) {
        let numOne = transformDoubleToString(number: result.numOne)
        let numTwo = transformDoubleToString(number: result.numTwo)
        let numThree = transformDoubleToString(number: result.numThree)
        let pass = result.pass ? "Yes!" : "No!"
        
        outputBoxOne.numberLabel.text = numOne
        outputBoxOne.backgroundColor = result.pass ? Constants.backgroundGreen : Constants.backgroundRed
        
        outputBoxTwo.numberLabel.text = numTwo
        outputBoxTwo.backgroundColor = result.pass ? Constants.backgroundGreen : Constants.backgroundRed
        
        outputBoxThree.numberLabel.text = numThree
        outputBoxThree.backgroundColor = result.pass ? Constants.backgroundGreen : Constants.backgroundRed
        
        resultLabel.text = pass
        resultLabel.textColor = result.pass ? Constants.backgroundGreen : Constants.backgroundRed        
    }
    
    private func transformDoubleToString(number: Double) -> String {
        if number == floor(number) {
            return String(Int(number))
        } else {
            return String(format: "%.1f", number)
        }
    }
        
}

