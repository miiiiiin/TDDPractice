//
//  CountViewController.swift
//  RxSwiftMVVMTestPractice
//
//  Created by Running Raccoon on 2021/09/28.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class CountViewController: UIViewController {
    
    @IBOutlet var button: UIButton!
    @IBOutlet var countLabel: UILabel!
    
    let viewModel = CountViewModel()
    
    private let disposeBag = DisposeBag()
    
    private lazy var input = CountViewModel.Input(didTapButton: self.button.rx.tap.asObservable())
    private lazy var output = self.viewModel.transform(input: input)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bind() {        
        output.count
            .map { String($0) }
            .drive(countLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
