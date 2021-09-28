//
//  ViewModel.swift
//  RxSwiftMVVMTestPractice
//
//  Created by Running Raccoon on 2021/09/28.
//

import Foundation

protocol ViewModel: AnyObject {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
