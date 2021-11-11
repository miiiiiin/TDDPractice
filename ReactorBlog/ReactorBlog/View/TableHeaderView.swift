//
//  TableHeaderView.swift
//  ReactorBlog
//
//  Created by Running Raccoon on 2021/10/27.
//

import UIKit

final class TableHeaderView: UIView {

    let filterButton = UIButton().then {
        $0.setTitle("All", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    let sortButton = UIButton().then {
        $0.setImage(UIImage(named: "icMenuFilled"), for: .normal)
        $0.backgroundColor = .green
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [self.filterButton, self.sortButton].forEach(self.addSubview(_:))
        self.backgroundColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.filterButton.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.right.equalTo(self.sortButton.snp.left)
        }
        
        self.sortButton.snp.makeConstraints { make in
            make.right.top.bottom.equalToSuperview()
            make.width.equalTo(self.frame.height)
        }
    }
}
