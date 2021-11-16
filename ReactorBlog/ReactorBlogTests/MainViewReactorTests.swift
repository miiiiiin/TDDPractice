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

    var test: RxExpect!
    var provider: StubServiceProvider!
    var reactor: MainViewReactor!
    
    override func setUp() {
        super.setUp()
        self.test = RxExpect()
        self.provider = StubServiceProvider()
        self.reactor = test.retain(MainViewReactor(provider: provider))
    }
    
    // MARK: - GET BLOG POST -
    
    func getBlogPostsTest() {
        
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
    
    
    // MARK: - GET CAFE POST -
    
    func testFetchPostsCafe() {
        // Action
        test.input(reactor.action, [
            Recorded.next(1, .updateFilter(.cafe)),
            Recorded.next(2, .refresh)
        ])
        
        // Assertion
        
        test.assert(reactor.state) { events in
            let state = events.elements
            
            expect(state.count) == 5
            expect(state[0].items.count) == 0
            
            // apply filter
            
            expect(state[1].filterType) == .cafe
            
            // refresh
            
            expect(state[2].isRefreshing) == true
            expect(state[3].items.count) == 25
            expect(state[4].isRefreshing) == false
        }
    }
    
    func testFetchPostsAll() {
        
        // Action
        
        test.input(reactor.action, [
            Recorded.next(1, .updateFilter(.all)),
            Recorded.next(2, .refresh)
        ])
        
        // Assertion
        
        test.assert(reactor.state) { events in
            let state = events.elements
            
            expect(state.count) == 5
            expect(state[0].items.count) == 0
            
            // apply filter
            
            expect(state[1].filterType) == .all
            
            // refresh
            
            expect(state[2].isRefreshing) == true
            expect(state[3].items.count) == 25
            expect(state[4].isRefreshing) == false
        }
    }
    
    
    // MARK: - Search History -
    
    func testSearchHistory() {
        
        // Action
        test.input(reactor.action, [
            Recorded.next(1, .updateSearchWord("iOS")),
            Recorded.next(2, .updateSearchHistory)
        ])
        
        // Assertion
        test.assert(reactor.state) { events in
            let state = events.elements
            let testKeyword = "iOS"
            expect(state.count) == 3
            
            expect(state[0].query) == ""
            expect(state[1].query) == testKeyword
            expect(state[2].searchHistory.contains(testKeyword)) == true
        }
    }
    
    
    // MARK: - Paging -
    
    func testPaging() {
        // Action
        
        test.input(reactor.action, [
            Recorded.next(1, .updateFilter(.blog)),
            Recorded.next(2, .refresh),
            Recorded.next(3, .loadMore)
        ])
        
        // Assertion
        
        test.assert(reactor.state) { events in
            let state = events.elements
            
            expect(state.count) == 8
            
            expect(state[0].items.count) == 0
            
            // apply filter
            expect(state[1].filterType) == .blog
            
            // refresh
            expect(state[2].isRefreshing) == true
            expect(state[3].items.count) == 25
            expect(state[4].isRefreshing) == false
            
            // loadMore
            
            expect(state[5].isRefreshing) == true
            expect(state[6].items.count) == 50
            expect(state[7].isRefreshing) == false
            
        }
    }
    
    
    // MARK: - Sort -
    
    func testSort() {
        
        // Action
        
        test.input(reactor.action, [
            Recorded.next(1, .refresh),
            Recorded.next(2, .updateSort(.recency))
        ])
        
        // Assertion
        
        test.assert(reactor.state) { events in
            let state = events.elements
           
            expect(state.count) == 0//5
            
            expect(state[0].items.count) == 0
            
            // refresh
            expect(state[1].isRefreshing) == true
            expect(state[2].items.count) == 25//50
            expect(state[3].isRefreshing) == false
            
            // original -> sortedData(datetime)
            let sortedData = state[2].items.sorted(by: { $0.dateTime > $1.dateTime })
            
            // sort check
            expect(state[4].items) == sortedData
        }
    }
}
