//
//  UIStackView.swift
//  Video Poker
//
//  Created by Anthony Lockett on 6/11/19.
//  Copyright © 2019 Anthony Lockett. All rights reserved.
//

import UIKit

extension UIStackView {
    func setBackgroundColor(color: UIColor) {
        let backgroundLayer = CAShapeLayer()
        self.layer.insertSublayer(backgroundLayer, at: 0)
        backgroundLayer.path = UIBezierPath(rect: self.bounds).cgPath
        backgroundLayer.fillColor = color.cgColor
    }
}
