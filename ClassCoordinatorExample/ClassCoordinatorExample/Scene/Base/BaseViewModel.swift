//
//  BaseViewModel.swift
//  ClassCoordinatorExample
//
//  Created by Running Raccoon on 2022/02/15.
//

import Foundation

class BaseViewModel {
    init() {
        #if DEBUG
            NSLog("ℹ️ Allocated ViewModel: \(self)")
        #endif
    }

    deinit {
        #if DEBUG
            NSLog("ℹ️ Dealllocated ViewModel: \(self)")
        #endif
    }
}
