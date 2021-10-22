//
//  TestRxScheduler.swift
//  GitHubTDDTests
//
//  Created by Running Raccoon on 2021/10/22.
//

import Foundation
import RxSwift
import RxTest
@testable import GitHubTDD

class TestRxScheduler: RxSchedulerType {
    
    var netowrk: SchedulerType
    var io: SchedulerType
    var main: SchedulerType
    
    init(_ scheduler: TestScheduler) {
        self.netowrk = scheduler
        self.io = scheduler
        self.main = scheduler
    }
}
