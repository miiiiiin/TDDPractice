//
//  TransitionModel.swift
//  SideDishExample
//
//  Created by Running Raccoon on 2022/02/21.
//

import Foundation

enum TransitionStyle {
    case root
    case push
}

enum TransitionError: Error {
    case navigationControllerMissing
    case connotPop
    case unknown
}
