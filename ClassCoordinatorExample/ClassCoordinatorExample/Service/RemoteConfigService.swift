////
////  remoteConfigService.swift
////  ClassCoordinatorExample
////
////  Created by Running Raccoon on 2022/02/15.
////
//
//import Foundation
//import RxCocoa
//import RxSwift
//
//protocol HasRemoteConfigService {
//    var remoteConfigService: RemoteConfigServiceProtocol { get }
//}
//
//protocol RemoteConfigServiceProtocol {
//    var config: BehaviorRelay<RemoteConfig> { get }
//    var mockData: BehaviorRelay<Bool> { get }
//
//    func fetchConfig()
//}
//
//final class RemoteConfigService: RemoteConfigServiceProtocol {
//    typealias Dependencies = HasHttpService
//
//    var config = BehaviorRelay<RemoteConfig>(value: RemoteConfig())
//    var mockData = BehaviorRelay<Bool>(value: false)
//
//    private let dependencies: Dependencies
//    private let bag = DisposeBag()
//
//    init(_ dependencies: Dependencies) {
//        self.dependencies = dependencies
//    }
//
//    func fetchConfig() {
//        let url = URL(string: EnvironmentConfiguration.shared.remoteConfigUrl)!
//        let headers = [
//            "Content-Type": "application/json;charset=UTF-8",
//            "Cache-Control": "no-cache"
//        ]
//
//        let fetchedConfig: Observable<RemoteConfig> = dependencies.httpService
//            .get(url: url, parameters: nil, headers: headers).share()
//
//        fetchedConfig.bind(to: config).disposed(by: bag)
//        fetchedConfig
//            .map { config in
//                if let mockDataForVersion = config.mockDataForVersion,
//                   let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
//                   mockDataForVersion == appVersion
//                {
////                    Log.info("Mocking data for this version \(appVersion)")
//                    return true
//                }
//                return false
//            }
//            .bind(to: mockData)
//            .disposed(by: bag)
//    }
//}
