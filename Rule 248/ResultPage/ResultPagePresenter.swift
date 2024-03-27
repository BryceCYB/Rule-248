//
//  ResultPagePresenter.swift
//  Rule 248
//
//  Created by Bryce Chan on 8/11/2023.
//

import UIKit

protocol ResultPagePresentationLogic {
    func presentSubmitAlert()
}

final class ResultPagePresenter: ResultPagePresentationLogic {
    
    weak var viewController: ResultPageDisplayLogic?
    
    func presentSubmitAlert() {
        viewController?.presentSubmitAlert()
    }
}
