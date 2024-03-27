//
//  InstructionPageViewController.swift
//  Rule 248
//
//  Created by Bryce Chan on 7/11/2023.
//

import UIKit

protocol InstructionPageDisplayLogic: AnyObject {
    
}

final class InstructionPageViewController: UIViewController {
    var interactor: InstructionPageBusinessLogic?
    var router: InstructionPageRoutingLogic?
    
    weak var delegate: PresentStartPageDelegate?
    
    private let introductionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        label.text = Constants.introductionText
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ruleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        label.text = Constants.ruleText
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let startLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        label.text = Constants.startText
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 22, weight: .bold)
        button.backgroundColor = Constants.backgroundGreen
        button.layer.cornerRadius = Constants.inputBoxCornerRadius
        button.addTarget(self, action: #selector(handleStartButtonTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let sampleCell: OutputCell = {
        let cell = OutputCell()
        cell.translatesAutoresizingMaskIntoConstraints = false
        return cell
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.addSubviews(introductionLabel, ruleLabel, sampleCell, startLabel, startButton)
                
        NSLayoutConstraint.activate([
            introductionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            introductionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 46),
            introductionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -34),
            
            ruleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ruleLabel.topAnchor.constraint(equalTo: introductionLabel.bottomAnchor, constant: 34),
            ruleLabel.widthAnchor.constraint(equalTo: introductionLabel.widthAnchor),
            
            sampleCell.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sampleCell.topAnchor.constraint(equalTo: ruleLabel.bottomAnchor),
            sampleCell.widthAnchor.constraint(equalTo: view.widthAnchor),
            sampleCell.heightAnchor.constraint(equalToConstant: 120),
            
            startLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startLabel.topAnchor.constraint(equalTo: sampleCell.bottomAnchor),
            startLabel.widthAnchor.constraint(equalTo: introductionLabel.widthAnchor),
            
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.topAnchor.constraint(equalTo: startLabel.bottomAnchor, constant: 46),
            startButton.widthAnchor.constraint(equalTo: introductionLabel.widthAnchor),
            startButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
        ])
    }
    
    private func setupSampleCell() {
        let sampleGuessResult = GuessResult(numOne: 2, numTwo: 4, numThree: 8, pass: true)
        sampleCell.setupCell(withResult: sampleGuessResult)
    }
    
    @objc private func handleStartButtonTap() {
        delegate?.presentStartPage()
    }

}

extension InstructionPageViewController: InstructionPageDisplayLogic {

}
