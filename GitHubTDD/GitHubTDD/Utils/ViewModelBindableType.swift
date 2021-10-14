//
//  ViewModelBindableType.swift
//  GitHubTDD
//
//  Created by Running Raccoon on 2021/10/13.
//


import UIKit

/**
 
 Each view controller conforming to the BindableType protocol
 will declare a viewModel variable and provide a bindViewModel() function
 to be called once the viewModel variable is assigned.
 This function will connect UI elements to observables and actions in the view model.
 
 */


protocol ViewModelBindableType {
    associatedtype ViewModelType
    //viewmodel의 타입은 vc에 따라 달라지므로 generic 프로토콜로 선언
    var viewModel: ViewModelType! { get set }
    func bindViewModel()
}

extension ViewModelBindableType where Self: UIViewController {
    
    // vc에 추가된 뷰모델 속성에 실제 뷰모델을 저장, bindviewmodel 함수를 자동으로 호출하는 메소드 구현
    
    mutating func bind(to viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        loadViewIfNeeded()
        bindViewModel()
        //개별 vc에서 bindViewModel()을 직접 호출할 필요가 없기때문에 코드가 단순해짐
    }
}

extension ViewModelBindableType where Self: UIView {
    
    mutating func bind(to viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        bindViewModel()
    }
}
