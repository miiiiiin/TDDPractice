//
//  SceneCoordinatorType.swift
//  GitHubTDD
//
//  Created by Running Raccoon on 2021/10/12.
//

import Foundation
import RxSwift

protocol SceneCoordinatorType {
    
    init(window: UIWindow)
    
    @discardableResult
    func transition(to scene: TargetScene) -> Observable<Void>
}
