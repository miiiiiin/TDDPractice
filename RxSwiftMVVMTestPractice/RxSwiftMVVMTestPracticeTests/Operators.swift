//
//  Operators.swift
//  RxSwiftMVVMTestPracticeTests
//
//  Created by Running Raccoon on 2021/09/28.
//

import Foundation
import RxSwift
import RxTest
import Nimble
import RxNimble

//Void타입의 Expectation을 비교하기 위한 함수 정의

public func equal<Void>(_ expectedValue: Void?) -> Predicate<Void> {
    return Predicate.define("equal <\(stringify(expectedValue))>") { actualExpression, msg in
        let actualValue = try actualExpression.evaluate()
        switch (expectedValue, actualValue) {
        case (nil, _?):
            return PredicateResult(status: .fail, message: msg.appendedBeNilHint())
        case (nil, nil), (_, nil):
            return PredicateResult(status: .fail, message: msg)
        default:
            var isEqual = false

            if String(describing: expectedValue).count != 0, String(describing: expectedValue) == String(describing: actualValue) {
                isEqual = true
            }
            return PredicateResult(bool: isEqual, message: msg)
        }
    }
}
