//
//  MemeGenTests.swift
//  MemeGenTests
//
//  Created by Running Raccoon on 2021/10/21.
//

import XCTest
import Nimble
import Quick
import RxTest
import RxSwift
@testable import MemeGen

class MainViewModelTests: QuickSpec {

    override func spec() {
        var scheduler: TestScheduler!
        var disposeBag: DisposeBag!
        var sut_viewModel: MainViewModel!
        var displayObserver: TestableObserver<UIImage>!
        var thumbnailsObserver: TestableObserver<[UIImage]>!
        
        func makeBinds() {
            sut_viewModel
                .displayImage
                .bind(to: displayObserver)
                .disposed(by: disposeBag)
        }
        
        // quick
        describe("MainViewModel") {
            beforeEach {
                scheduler = TestScheduler(initialClock: 0)
                disposeBag = DisposeBag()
                sut_viewModel = MainViewModel()
                
                displayObserver = scheduler.createObserver(UIImage.self)
                thumbnailsObserver = scheduler.createObserver([UIImage].self)
                
                makeBinds()
            }
            
            it("should start display with placeholder") {
                expect(displayObserver.events) == [
                    .next(0, #imageLiteral(resourceName: "placeholder-meme"))
                    
                ]
            }
            
            it("should start thumbnails with images") {
                expect(sut_viewModel.thumbnails) == [#imageLiteral(resourceName: "meme0"), #imageLiteral(resourceName: "meme1")]
            }
            
            describe("when onThumbnailTap emits") {
                beforeEach {
                    scheduler.createColdObservable([
                        .next(10, 0),
                        .next(20, 1),
                        .next(30, 2),
                        .next(40, -1)
                    ])
                    .bind(to: sut_viewModel.onThumbnailTap)
                    .disposed(by: disposeBag)
                    
                    scheduler.start()
                }
            }
        }
        
    }
    

}
