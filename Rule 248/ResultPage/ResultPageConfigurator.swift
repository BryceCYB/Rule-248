//
//  ResultPageConfigurator.swift
//  Rule 248
//
//  Created by Bryce Chan on 7/11/2023.
//

struct ResultPageConfigurator {
    
    static func createScene() -> ResultPageViewController {
        let viewController = ResultPageViewController()
        let presenter = ResultPagePresenter()
        let interactor = ResultPageInteractor()
        let worker = ResultPageWorker()
        viewController.interactor = interactor
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        return viewController
    }
}
