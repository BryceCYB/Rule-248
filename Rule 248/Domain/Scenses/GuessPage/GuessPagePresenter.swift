//
//  GuessPagePresenter.swift
//  Rule 248
//
//  Created by Bryce Chan on 7/11/2023.
//

import UIKit

protocol GuessPagePresentationLogic {
    func updateGuessResult(response: GuessPage.GuessResults.Response)
}

final class GuessPagePresenter: GuessPagePresentationLogic {
    weak var viewController: GuessPageDisplayLogic?

    func updateGuessResult(response: GuessPage.GuessResults.Response) {
        let viewModel = GuessPage.GuessResults.ViewModel(guessResults: response.guessResults)
        viewController?.updateGuessResults(viewModel: viewModel)
    }
}
