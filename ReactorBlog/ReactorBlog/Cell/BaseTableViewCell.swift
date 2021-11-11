//
//  BaseTableViewCell.swift
//  ReactorBlog
//
//  Created by Running Raccoon on 2021/10/27.
//

import Foundation
import UIKit
import RxSwift

class BaseTableViewCell: UITableViewCell {
    
    var disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .white
    }
    
    // 편의 생성자를 통해 재정의된 이니셜라이저 호출
    required convenience init?(coder: NSCoder) {
        self.init(style: .default, reuseIdentifier: nil)
    }
}
