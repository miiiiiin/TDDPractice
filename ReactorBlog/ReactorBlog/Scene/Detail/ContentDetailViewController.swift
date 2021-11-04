//
//  ContentDetailViewController.swift
//  ReactorBlog
//
//  Created by Running Raccoon on 2021/11/03.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

final class ContentDetailViewController: BaseViewController, ReactorKit.View {

    typealias Reactor = ContentDetailReactor
    
    struct Metric {
        static let stackViewLeftRight = 25.f
        static let stackViewTop = 40.f
        static let thumbnailImageViewHeight = 200.f
        static let urlButtonWidth = 60.f
        static let horizontalStackViewHeight = 60.f
        static let urlButtonCornerRadius = 5.f
    }
    
    struct Font {
        static let nameLabel = UIFont.systemFont(ofSize: 15, weight: .black)
        static let titleLabel = UIFont.systemFont(ofSize: 20, weight: .semibold)
        static let contentsLabel = UIFont.systemFont(ofSize: 17, weight: .medium)
        static let dateLabel = UIFont.systemFont(ofSize: 15, weight: .medium)
    }
    
    // MARK: - UI -
    
    let thumbnailImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    let nameLabel = UILabel().then {
        $0.font = Font.nameLabel
    }
    
    let titleLabel = UILabel().then {
        $0.font = Font.titleLabel
    }
    
    let contentsLabel = UILabel().then {
        $0.font = Font.contentsLabel
    }
    
    let dateLabel = UILabel().then {
        $0.font = Font.dateLabel
    }
    
    let urlLabel = UILabel().then {
        $0.font = Font.dateLabel
        $0.textColor = .darkGray
    }
    
    let urlButton = UIButton().then {
        $0.setImage(UIImage(named: "urlIcon"), for: .normal)
        $0.backgroundColor = .lightGray
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = Metric.urlButtonCornerRadius
    }
    
    lazy var verticalStackView = UIStackView(
        arrangedSubviews: [
            thumbnailImageView,
            nameLabel,
            titleLabel,
            contentsLabel,
            dateLabel
        ]
    )
    .then {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .fill
        $0.spacing = 25
        $0.backgroundColor = .lightGray
    }
    
    // MARK: - Init -
    
    init(reactor: Reactor) {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(verticalStackView)
    }
    
    override func setupConstraints() {
        self.verticalStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        self.thumbnailImageView.snp.makeConstraints { make in
            make.height.equalTo(Metric.thumbnailImageViewHeight)
        }
        
        self.urlButton.snp.makeConstraints { make in
            make.width.equalTo(Metric.urlButtonWidth)
        }
    }
    
    func bind(reactor: Reactor) {
     
        // MARK: - State -
        
        reactor.state.map { $0.thumbnail }
            .bind(to: self.thumbnailImageView.rx.image(placeholder: UIImage(named: "placeholder")))
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.name }
            .bind(to: self.nameLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.title }
            .bind(to: self.titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.contents }
            .bind(to: self.contentsLabel.rx.text)
            .disposed(by: disposeBag)
        
    }
}
