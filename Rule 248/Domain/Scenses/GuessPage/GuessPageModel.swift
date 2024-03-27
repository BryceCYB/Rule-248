//
//  GuessPageModel.swift
//  Rule 248
//
//  Created by Bryce Chan on 7/11/2023.
//

import UIKit

enum GuessPage {
    
    enum GuessResults {
        struct Request {
            
        }
        
        struct Response {
            let guessResults: [GuessResult]
        }
        
        struct ViewModel {
            let guessResults: [GuessResult]
        }
    }
}
