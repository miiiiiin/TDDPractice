//
//  MainViewController.swift
//  MemeGen
//
//  Created by Running Raccoon on 2021/10/21.
//

import Foundation
import UIKit
import RxSwift

class MainViewController: UIViewController {
    
    @IBOutlet var displayImageView: UIImageView!
    @IBOutlet var clearButton: UIButton!
    @IBOutlet var proceedButton: UIButton!
    @IBOutlet var tableView: UITableView!
    
    private let viewModel = MainViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureLayout()
    }
    
    private func configureLayout() {
        
    }
    
    private func configureTableView() {
        
    }
}
