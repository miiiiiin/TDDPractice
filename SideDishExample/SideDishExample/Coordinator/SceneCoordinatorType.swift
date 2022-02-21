//
//  SceneCoordinatorType.swift
//  SideDishExample
//
//  Created by Running Raccoon on 2022/02/21.
//

import RxSwift

protocol SceneCoordinatorType {
    @discardableResult
    func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable
}

