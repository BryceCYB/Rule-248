//
//  ResultPageInteractor.swift
//  Rule 248
//
//  Created by Bryce Chan on 8/11/2023.
//

import UIKit

protocol ResultPageBusinessLogic {
    func presentSubmitAlert()
}

protocol ResultPageDataStore {
    
}

class ResultPageInteractor: ResultPageBusinessLogic, ResultPageDataStore {
    var presenter: ResultPagePresentationLogic?
    var worker: ResultPageWorker?
    
    func presentSubmitAlert() {
        print("123")
        presenter?.presentSubmitAlert()
    }
}
