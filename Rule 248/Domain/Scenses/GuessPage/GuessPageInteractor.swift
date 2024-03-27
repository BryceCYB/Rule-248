//
//  GuessPageInteractor.swift
//  Rule 248
//
//  Created by Bryce Chan on 7/11/2023.
//

import UIKit

protocol GuessPageBusinessLogic {
    func parseGuessInput(inputOne: String, inputTwo: String, inputThree: String) -> Bool
}

protocol GuessPageDataStore {
    
}

class GuessPageInteractor: GuessPageBusinessLogic, GuessPageDataStore {
    var presenter: GuessPagePresentationLogic?
    var worker: GuessPageWorker?
    
    var guessResults = [GuessResult]()
    
    func parseGuessInput(inputOne: String, inputTwo: String, inputThree: String) -> Bool {
        guard let worker = worker else {
            return false
        }
        
        if worker.validateStringInput(stringOne: inputOne, stringTwo: inputTwo, stringThree: inputThree) == false {
            return false
        }
        
        if let guessResult = worker.getGuessResult(stringOne: inputOne, stringTwo: inputTwo, stringThree: inputThree) {
            guessResults.append(guessResult)
            
            let response = GuessPage.GuessResults.Response(guessResults: guessResults)
            presenter?.updateGuessResult(response: response)
        }
        
        return true
    }
    
}
