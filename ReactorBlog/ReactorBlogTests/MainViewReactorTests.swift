//
//  MainViewReactorTests.swift
//  ReactorBlogTests
//
//  Created by Running Raccoon on 2021/11/05.
//

import XCTest
import Nimble
import RxTest
import RxExpect

@testable import ReactorBlog

class MainViewReactorTests: XCTestCase {

    
    // MARK: - GET BLOG POST -
    
    func getBlogPostsTest() {
        let test = RxExpect()
        let provider = StubServiceProvider()
        let reactor = test.retain(MainViewReactor(provider: provider))
        
        // Action
        
        test.input(reactor.action, [
            Recorded.next(1, .updateFilter(.blog)),
            Recorded.next(2, .refresh)
        ])
        
        // Assertion
        
        test.assert(reactor.state) { events in
            let state = events.elements
            
            expect(state.count) == 5
            expect(state[0].items.count) == 0
            
            // apply filter
            expect(state[1].filterType) == .blog
            
            // refresh
            
            expect(state[2].isRefreshing) == true
            expect(state[3].items.count) == 25
            expect(state[4].isRefreshing) == false
        }
    }
}
