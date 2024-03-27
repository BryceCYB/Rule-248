//
//  GuessPageViewController.swift
//  Rule 248
//
//  Created by Bryce Chan on 7/11/2023.
//

import UIKit

protocol GuessPageDisplayLogic: AnyObject {
    func updateGuessResults(viewModel: GuessPage.GuessResults.ViewModel)
}

final class GuessPageViewController: UIViewController {
    var interactor: GuessPageBusinessLogic?
    
    var guessResults = [GuessResult]()
    
    private let resultCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 2
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 14, left: 0, bottom: 14, right: 0)
        collectionView.register(OutputCell.self, forCellWithReuseIdentifier: OutputCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let inputCell = InputCell()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCheckButton()
        handleKeyboardAppear()
        addSampleCell()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        TimerService.shared.getStartTime()
    }

    private func setupView() {
        view.addSubviews(resultCollectionView, inputCell)
                
        NSLayoutConstraint.activate([
            resultCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            resultCollectionView.bottomAnchor.constraint(equalTo: inputCell.topAnchor),
            resultCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            inputCell.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inputCell.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            inputCell.widthAnchor.constraint(equalTo: view.widthAnchor),
            inputCell.heightAnchor.constraint(equalToConstant: 100),
        ])
        
        resultCollectionView.delegate = self
        resultCollectionView.dataSource = self
        
        inputCell.inputBoxOne.numberTextField.delegate = self
        inputCell.inputBoxTwo.numberTextField.delegate = self
        inputCell.inputBoxThree.numberTextField.delegate = self
    }
    
    private func setupCheckButton() {
        inputCell.checkButton.addTarget(self, action: #selector(handleCheckButtonTap), for: .touchUpInside)
    }
    
    private func handleKeyboardAppear() {
        addDismissKeyboardGesture()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), 
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc private func handleCheckButtonTap() {
        guard let inputOne = inputCell.inputBoxOne.numberTextField.text,
           let inputTwo = inputCell.inputBoxTwo.numberTextField.text,
           let inputThree = inputCell.inputBoxThree.numberTextField.text 
        else {
            return
        }
        
        if let isValid = interactor?.parseGuessInput(inputOne: inputOne, inputTwo: inputTwo, inputThree: inputThree) {
            inputCell.backgroundColor = isValid ? .lightGray : Constants.backgroundRed
        }
        clearTextField()
    }
    
    private func clearTextField() {
        inputCell.inputBoxOne.numberTextField.text = ""
        inputCell.inputBoxTwo.numberTextField.text = ""
        inputCell.inputBoxThree.numberTextField.text = ""
    }
    
    private func addSampleCell() {
        _ = interactor?.parseGuessInput(inputOne: "2", inputTwo: "4", inputThree: "8")
    }
    
}

extension GuessPageViewController: GuessPageDisplayLogic, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UITextFieldDelegate {
    
    // MARK: - GuessPageDisplayLogic
    
    func updateGuessResults(viewModel: GuessPage.GuessResults.ViewModel) {
        guessResults = viewModel.guessResults
        
        DispatchQueue.main.async {
            self.resultCollectionView.reloadData()
        }
    }
    
    // MARK: - CollectionView delegates
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return guessResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OutputCell.identifier, for: indexPath) as! OutputCell
        cell.setupCell(withResult: guessResults[indexPath.row])
        return cell
    }
    
    // MARK: - Keyboard handling
    
    private func addDismissKeyboardGesture() {
       let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
       view.addGestureRecognizer(tap)
   }
   
   @objc private func dismissKeyboard(){
       view.endEditing(true)
   }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    // MARK: - TextField delegates
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""

        guard let stringRange = Range(range, in: currentText) else { return false }

        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        return updatedText.count <= 6
    }
}
