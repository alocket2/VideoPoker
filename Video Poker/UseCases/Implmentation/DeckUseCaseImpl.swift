//
//  DeckUseCaseImpl.swift
//  Video Poker
//
//  Created by Anthony Lockett on 6/10/19.
//  Copyright © 2019 Anthony Lockett. All rights reserved.
//

import Foundation

final class DeckUseCaseImpl: DeckProtocol {
    func shuffle(deck: Deck) -> Deck {
        var tmpDeck = deck
        return tmpDeck.shuffle()
    }

    func deal() {
        
    }
}
