//
//  ScoreUseCase.swift
//  Video Poker
//
//  Created by Anthony Lockett on 6/11/19.
//  Copyright © 2019 Anthony Lockett. All rights reserved.
//

import Foundation

protocol Score: class {
    func tally(hand: Deck) -> Int
}
