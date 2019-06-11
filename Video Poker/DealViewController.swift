//
//  ViewController.swift
//  Video Poker
//
//  Created by Anthony Lockett on 6/10/19.
//  Copyright © 2019 Anthony Lockett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let manager = DeckManager.shared
        guard let deck = manager.generate() else { return }
        
        for card in deck {
            print(card)
        }
    }
}

