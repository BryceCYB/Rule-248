//
//  InstructionPageInteractor.swift
//  Rule 248
//
//  Created by Bryce Chan on 7/11/2023.
//

import UIKit

protocol InstructionPageBusinessLogic {
    
}

protocol InstructionPageDataStore {
    
}

class InstructionPageInteractor: InstructionPageBusinessLogic, InstructionPageDataStore {
    var presenter: InstructionPagePresentationLogic?
    var worker: InstructionPageWorker?
}
