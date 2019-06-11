//
//  DeckProtocol.swift
//  Video Poker
//
//  Created by Anthony Lockett on 6/10/19.
//  Copyright © 2019 Anthony Lockett. All rights reserved.
//

import Foundation

protocol Dealer: class {
    func shuffle(deck: inout Deck) -> Deck
    func deal() -> Deck?
}
