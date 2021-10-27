//
//  ContentCell.swift
//  ReactorBlog
//
//  Created by Running Raccoon on 2021/10/27.
//

import UIKit
import ReactorKit

final class ContentCell: BaseTableViewCell, View {
    typealias Reactor = ContentCellReactor
    
    struct Font {
        static let kindLabel = UIFont.systemFont(ofSize: 20, weight: .black)
        static let nameLabel = UIFont.systemFont(ofSize: 20, weight: .medium)
        static let titleLabel = UIFont.systemFont(ofSize: 17, weight: .regular)
        static let dateLabel = UIFont.systemFont(ofSize: 15, weight: .medium)
    }
    
    struct Metric {
        static let cellPddding = 15.f
        static let thumbnailSize = 100.f
        static let kindLabelWidth = 20.f
        static let nameLabelLeft = 5.f
        static let titleLabelTop = 5.f
    }
    
    lazy var thumbnail: UIImageView = {
        let view = UIImageView()
        return view
    }()

    let kindLabel = UILabel().then {
        $0.font = Font.kindLabel
        $0.textColor = .blue
    }
    
    let nameLabel = UILabel().then {
        $0.font = Font.nameLabel
    }
    
    let titleLabel = UILabel().then {
        $0.numberOfLines = 2
    }
    
    let dateLabel = UILabel().then {
        $0.font = Font.dateLabel
        $0.textColor = .lightGray
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [self.thumbnail, self.kindLabel, self.nameLabel, self.titleLabel, self.dateLabel].forEach(self.contentView.addSubview(_:))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.thumbnail.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-Metric.cellPddding)
            make.width.height.equalTo(Metric.thumbnailSize)
            make.centerY.equalToSuperview()
        }
        
        self.kindLabel.snp.makeConstraints { make in
            make.left.top.equalTo(Metric.cellPddding)
            make.width.equalTo(Metric.kindLabelWidth)
        }
        
        self.nameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.kindLabel.snp.top)
            make.left.equalTo(kindLabel.snp.right).offset(Metric.nameLabelLeft)
            make.right.equalTo(self.thumbnail.snp.left).offset(-Metric.cellPddding)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.nameLabel.snp.bottom).offset(Metric.titleLabelTop)
            make.left.equalToSuperview().offset(Metric.cellPddding)
            make.right.equalTo(self.thumbnail.snp.left).offset(-Metric.cellPddding)
        }
        
        self.dateLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Metric.cellPddding)
            make.bottom.equalToSuperview().offset(-Metric.cellPddding)
            make.right.equalTo(self.thumbnail.snp.left).offset(-Metric.cellPddding)
        }
    }
    
    func bind(reactor: ContentCellReactor) {
        self.reactor = reactor
    }    
}
