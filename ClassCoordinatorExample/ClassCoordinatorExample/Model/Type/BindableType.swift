//
//  BindableType.swift
//  ClassCoordinatorExample
//
//  Created by Running Raccoon on 2022/02/15.
//

import RxSwift
import UIKit

protocol BindableType {
    associatedtype ViewModelType

    var viewModel: ViewModelType! { get set }

    /// Binds view model after ViewController of the scene is initiated
    func bindViewModel()
}

extension BindableType where Self: UIViewController {
    mutating func bindViewModel(to model: Self.ViewModelType) {
        viewModel = model
        loadViewIfNeeded()
        bindViewModel()
    }
}
