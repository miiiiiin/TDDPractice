//
//  RxMainNetworkTests.swift
//  SideDishExampleTests
//
//  Created by Running Raccoon on 2022/02/21.
//

import XCTest
@testable import SideDishExample
import RxSwift
import RxBlocking

class RxMainNetworkTests: XCTestCase {
    
    private var sessionManagerStub: SessionManagerStub!
    private var networkManager: Networkable!
    private var disposeBag: DisposeBag!
    
    override func setUp() {
        sessionManagerStub = SessionManagerStub()
        networkManager = NetworkManager(sessionManager: sessionManagerStub)
        disposeBag = DisposeBag()
        super.setUp()
    }
    
    func test_fetchSidedishes() {
        networkManager.get(type: SidedishItem.self, endpoint: .main)
            .subscribe(onNext: { _ in })
            .disposed(by: disposeBag)
        
        let params = sessionManagerStub.requestParameters
        
        debugPrint("test side params: \(params)")
        
        XCTAssertEqual(try params?.url.asURL().absoluteString, "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/main")
        XCTAssertEqual(params?.method, .get)
    }
}
