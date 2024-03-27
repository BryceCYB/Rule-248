//
//  ResultPageViewController.swift
//  Rule 248
//
//  Created by Bryce Chan on 7/11/2023.
//

import UIKit

protocol ResultPageDisplayLogic: AnyObject {
    func presentSubmitAlert()
}


final class ResultPageViewController: UIViewController {
    
    var interactor: ResultPageBusinessLogic?
    
    var countingTimer: Timer?
    var timerStarted = false
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let startTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        label.text = "Start: "
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let endTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textAlignment = .right
        label.textColor = .black
        label.text = ""
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let totalTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        label.text = ""
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let answerTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.textColor = .black
        textView.textAlignment = .left
        textView.font = .systemFont(ofSize: 18)
        textView.layer.borderWidth = 2
        textView.layer.borderColor = UIColor.darkGray.cgColor
        textView.layer.cornerRadius = Constants.inputBoxCornerRadius
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 22, weight: .bold)
        button.backgroundColor = Constants.backgroundGreen
        button.layer.cornerRadius = Constants.inputBoxCornerRadius
        button.addTarget(self, action: #selector(handleSubmitButtonTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = Constants.backgroundGreen
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupResultLabel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setStartTimeLabel()
    }
    
    private func setupView() {
        view.addSubviews(resultLabel, answerTextView, submitButton, startTimeLabel, endTimeLabel, totalTimeLabel, loadingIndicator)
                
        NSLayoutConstraint.activate([
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 34),
            resultLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -34),
            
            answerTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            answerTextView.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 18),
            answerTextView.widthAnchor.constraint(equalTo: resultLabel.widthAnchor),
            answerTextView.heightAnchor.constraint(equalToConstant: 320),
            
            startTimeLabel.leftAnchor.constraint(equalTo: answerTextView.leftAnchor, constant: 22),
            startTimeLabel.topAnchor.constraint(equalTo: answerTextView.bottomAnchor, constant: 18),
            startTimeLabel.widthAnchor.constraint(equalToConstant: 150),
            startTimeLabel.heightAnchor.constraint(equalToConstant: 22),
            
            endTimeLabel.rightAnchor.constraint(equalTo: answerTextView.rightAnchor, constant: -22),
            endTimeLabel.topAnchor.constraint(equalTo: answerTextView.bottomAnchor, constant: 18),
            endTimeLabel.widthAnchor.constraint(equalToConstant: 140),
            endTimeLabel.heightAnchor.constraint(equalToConstant: 22),
            
            totalTimeLabel.leftAnchor.constraint(equalTo: startTimeLabel.leftAnchor),
            totalTimeLabel.topAnchor.constraint(equalTo: startTimeLabel.bottomAnchor, constant: 8),
            totalTimeLabel.widthAnchor.constraint(equalToConstant: 140),
            totalTimeLabel.heightAnchor.constraint(equalToConstant: 22),
            
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.topAnchor.constraint(equalTo: totalTimeLabel.bottomAnchor, constant: 18),
            submitButton.widthAnchor.constraint(equalTo: resultLabel.widthAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupResultLabel() {
        let normalText = Constants.resultText
        let boldText = Constants.resultBoldText
        let attributedString = NSMutableAttributedString(string: normalText)
        let textAttribute = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: .black)]
        let boldString = NSMutableAttributedString(string: boldText, attributes: textAttribute)
        
        attributedString.append(boldString)
        resultLabel.attributedText = attributedString
    }
    
    private func setStartTimeLabel() {
        if timerStarted == false {
            startTimeLabel.text?.append(TimerService.shared.startTime ?? "")
            timerStarted = true
        }
    }

    @objc private func handleSubmitButtonTap() {
        TimerService.shared.stopTimer()
        
        totalTimeLabel.text?.append("Total: \(TimerService.shared.totalTime ?? "")")
        endTimeLabel.text?.append("End: \(TimerService.shared.endTime ?? "")")
        
        submitButton.isEnabled = false
        submitButton.backgroundColor = .darkGray
        
        loadingIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.loadingIndicator.stopAnimating()
//            self.interactor?.presentSubmitAlert()
            self.presentSubmitAlert()
        }
    }
}

extension ResultPageViewController: ResultPageDisplayLogic {
    
    func presentSubmitAlert() {
        let submittedDialog = UIAlertController(title: "Submit Success!", message: "", preferredStyle: .alert)

        let dismissAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
//            submittedDialog.dismiss(animated: true)
        })
        
        submittedDialog.addAction(dismissAction)
        present(submittedDialog, animated: true)
    }
    
    
}
