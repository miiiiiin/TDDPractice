//
//  RxSchedulerType.swift
//  GitHubTDD
//
//  Created by Running Raccoon on 2021/10/14.
//

import Foundation
import RxSwift

protocol RxSchedulerType {
    var io: SchedulerType { get }
    var netowrk: SchedulerType { get }
    var main: SchedulerType { get }
}

class RxScheduler: RxSchedulerType {
    let io: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .utility)
    let netowrk: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .utility)
    let main: SchedulerType = MainScheduler()
}
