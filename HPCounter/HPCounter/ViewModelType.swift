//
//  ViewModelType.swift
//  HPCounter
//
//  Created by Running Raccoon on 2021/10/19.
//

import Foundation

protocol ViewModelType: class {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}
