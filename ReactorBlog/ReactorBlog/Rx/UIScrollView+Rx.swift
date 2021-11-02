//
//  UIScrollView+Rx.swift
//  ReactorBlog
//
//  Created by Running Raccoon on 2021/11/02.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIScrollView {
    
    var reachedBottom: ControlEvent<Void> {
        let source = self.contentOffset
            .filter { [weak base = self.base] offset in // 외부 변수 base의 rc 수 증가를 방지 하기 위해 약한 참조 사용 (약한 참조하면 옵셔널로 바뀜)
                guard let base = base else { return false }
                return base.isReachedBottom(tableViewContentSizeY: base.contentSize.height)
            }
            .map { _ in Void() }
        
        return ControlEvent(events: source)
    }
}

extension UIScrollView {
    
    func isReachedBottom(tableViewContentSizeY: CGFloat) -> Bool {
        let contentOffsetY = self.contentOffset.y
        let paginationY = tableViewContentSizeY * 0.3
        print("offset y check: \(contentOffsetY), \(tableViewContentSizeY - paginationY), \(contentOffsetY > (tableViewContentSizeY - paginationY))")
        return contentOffsetY > (tableViewContentSizeY - paginationY)
    }
}
