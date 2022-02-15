//
//  UIPrimaryButton.swift
//  ClassCoordinatorExample
//
//  Created by Running Raccoon on 2022/02/15.
//

import UIKit

class UIPrimaryButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()

        setTitleColor(.white, for: .normal)
//        titleLabel?.font = UIFontMetrics(forTextStyle: .body)
//            .scaledFont(for: UIFont.Grades.primaryButton)
        titleLabel?.adjustsFontForContentSizeCategory = true

        clipsToBounds = true
        layer.cornerRadius = frame.size.height / 2
//        apply(gradient: UIColor.Theme.primaryGradient)
    }
}
