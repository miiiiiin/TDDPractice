//
//  MainViewModel.swift
//  MemeGen
//
//  Created by Running Raccoon on 2021/10/21.
//

import Foundation
import RxSwift
import RxCocoa

class MainViewModel {
    
    // Bind
    let displayImage: Observable<UIImage>
    let onResetTap = PublishSubject<Void>()
    let onThumbnailTap = PublishSubject<Int>()
    let thumbnails = [#imageLiteral(resourceName: "meme0"), #imageLiteral(resourceName: "meme1")]
    
    // Private
    private let selectedImage = BehaviorRelay<UIImage?>(value: nil)
    private let disposeBag = DisposeBag()
    private let scheduler: SchedulerType
    
    init(scheduler: SchedulerType = MainScheduler.instance) {
        self.scheduler = scheduler
        
        displayImage = selectedImage
            .map { $0 ?? Placeholder() }
            .asObservable()
        
        bind()
    }
    
    private func bind() {
        onResetTap
            .map { nil }
            .bind(to: selectedImage)
            .disposed(by: disposeBag)
        
        onThumbnailTap
            .map { [thumbnails] in // 외부 변수 캡처리스트 사용
                thumbnails[safe: $0]
            }
            .flatMap {
                $0.map(Observable.just) ?? .empty()
//                Observable.just($0)
            }
            .bind(to: selectedImage)
            .disposed(by: disposeBag)
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}

