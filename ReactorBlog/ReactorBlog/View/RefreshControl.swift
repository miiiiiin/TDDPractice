//
//  RefreshControl.swift
//  ReactorBlog
//
//  Created by Running Raccoon on 2021/10/27.
//

import UIKit

final class RefreshControl: UIRefreshControl {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override convenience init() {
        self.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }    
}
