//
//  InstructionPageConfigurator.swift
//  Rule 248
//
//  Created by Bryce Chan on 7/11/2023.
//

import Foundation

struct InstructionPageConfigurator {
    
    static func createScene() -> InstructionPageViewController {
        let viewController = InstructionPageViewController()
        let presenter = InstructionPagePresenter()
        let interactor = InstructionPageInteractor()
        let router = InstructionPageRouter()
        let worker = InstructionPageWorker()
        viewController.interactor = interactor
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        viewController.router = router
        router.viewController = viewController
        router.dataStore = interactor
        return viewController
    }
}
