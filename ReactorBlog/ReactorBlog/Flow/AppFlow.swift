//
//  AppFlow.swift
//  ReactorBlog
//
//  Created by Running Raccoon on 2021/10/26.
//

import UIKit
import RxSwift
import RxCocoa
import RxFlow

final class AppFlow: Flow {
    
    private lazy var rootViewController = UINavigationController()
    
    var root: Presentable {
        self.rootViewController
    }
    
    init() {
        
    }
    
    func navigate(to step: Step) -> FlowContributors {
        return .none
    }
    
    
    deinit {
        print("❎ \(type(of: self)): \(#function)")
    }
}
