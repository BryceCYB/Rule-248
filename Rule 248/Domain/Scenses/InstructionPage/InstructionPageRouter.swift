//
//  InstructionPageRouter.swift
//  Rule 248
//
//  Created by Bryce Chan on 7/11/2023.
//

import UIKit

protocol InstructionPageRoutingLogic {
    
}

protocol InstructionPageDataPassing {
    var dataStore: InstructionPageDataStore? { get }
}

class InstructionPageRouter: NSObject, InstructionPageRoutingLogic, InstructionPageDataPassing {
    weak var viewController: InstructionPageViewController?
    var dataStore: InstructionPageDataStore?
}

