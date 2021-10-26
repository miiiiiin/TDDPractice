/// Copyright (c) 2021 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import XCTest
@testable import BullsEye

var sut: URLSession!

class BullsEyeSlowTests: XCTestCase {

    override func setUpWithError() throws {
      
      try super.setUpWithError()
      sut = URLSession(configuration: .default)
    }

    override func tearDownWithError() throws {
      
      sut = nil
      try super.tearDownWithError()
    }
  
  // Asynchronous test: success fast, failure slow
  func testValidApiCallGetsHTTPStatusCode200() throws {
    
    let networkMonitor = NetworkMonitor.shared
    
    try XCTSkipUnless(networkMonitor.isReachable, "Network connectivity needed for this test.")
    
      // given
      let urlString =
        "http://www.randomnumberapi.com/api/v1.0/random?min=0&max=100&count=1"
    
      let url = URL(string: urlString)!
    
    // Failure Case (Failing Fast)
//    let url = URL(string: "http://www.randomnumberapi.com/test")!

      // 1
      let promise = expectation(description: "Status code: 200")
    
      // when
      
    let dataTask = sut.dataTask(with: url) { _, response, error in
      
      // then
      
      if let error = error {
        XCTFail("Error Occured: \(error.localizedDescription)")
      } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
        
        if statusCode == 200 {
          // 2
          promise.fulfill()
        } else {
          XCTFail("Status Code is not success: \(statusCode)")
        }
      }
    }
    dataTask.resume()
    
    // 3
    wait(for: [promise], timeout: 5)
  }
  
  func testApiCallCompletes() throws {
    
    let networkMonitor = NetworkMonitor.shared
    
    try XCTSkipUnless(networkMonitor.isReachable, "Network connectivity needed for this test.")
    
    // given
//    let urlString = "http://www.randomnumberapi.com/test"
    let urlString = "http://www.randomnumberapi.com/api/v1.0/random?min=0&max=100&count=1"
    let url = URL(string: urlString)!
    let promise = expectation(description: "Completion handler invoked")
    var statusCode: Int?
    var responseError: Error?
    
    // when
    let dataTask = sut.dataTask(with: url) { _, response, error in
      statusCode = (response as? HTTPURLResponse)?.statusCode
      responseError = error
      promise.fulfill()
    }
    dataTask.resume()
    wait(for: [promise], timeout: 5)
    
    // then
    XCTAssertNil(responseError)
    XCTAssertEqual(statusCode, 200)
    
  }
}