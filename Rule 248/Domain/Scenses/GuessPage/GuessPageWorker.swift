//
//  GuessPageWorker.swift
//  Rule 248
//
//  Created by Bryce Chan on 7/11/2023.
//

import Foundation

final class GuessPageWorker {
    
    func validateStringInput(stringOne: String, stringTwo: String, stringThree: String) -> Bool {
        return (Double(stringOne) != nil) && (Double(stringTwo) != nil) && (Double(stringThree) != nil)
    }
    
    func getGuessResult(stringOne: String, stringTwo: String, stringThree: String) -> GuessResult? {
        if let numOne = Double(stringOne), let numTwo = Double(stringTwo), let numThree = Double(stringThree) {
            let pass = abs(numOne) < abs(numTwo) && abs(numTwo) < abs(numThree) ? true : false
            
            return GuessResult(numOne: numOne, numTwo: numTwo, numThree: numThree, pass: pass)
        }
        return nil
    }
}
