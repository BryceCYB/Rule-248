//
//  GuessPageConfigurator.swift
//  Rule 248
//
//  Created by Bryce Chan on 7/11/2023.
//

struct GuessPageConfigurator {
    
    static func createScene() -> GuessPageViewController {
        let viewController = GuessPageViewController()
        let presenter = GuessPagePresenter()
        let interactor = GuessPageInteractor()
        let worker = GuessPageWorker()
        viewController.interactor = interactor
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        return viewController
    }
}
