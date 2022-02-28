//
//  MainSection.swift
//  SideDishExample
//
//  Created by Running Raccoon on 2022/02/22.
//


import Foundation
import RxDataSources

struct MainSection {
    var header: String
    var category: String
    var items: [SidedishItem]
}

extension MainSection: AnimatableSectionModelType {
    var identity: String {
        return header
    }
    
    init(original: MainSection, items: [SidedishItem]) {
        self = original
        self.items = items
    }
}
