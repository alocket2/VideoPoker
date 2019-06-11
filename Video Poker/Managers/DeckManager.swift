//
//  DeckManager.swift
//  Video Poker
//
//  Created by Anthony Lockett on 6/10/19.
//  Copyright © 2019 Anthony Lockett. All rights reserved.
//

import Foundation

final class DeckManager {
    static let shared = DeckManager()
    
    /**
        Generates a deck of cards
        Run time O^2 - Could get better potentially using some HOF
 
        - Returns: A shuffled deck of cards
   */
 
    func generate() -> Deck? {
        var cards = [Card]()
        let max: CardRank = .ace
        let suits: [CardSuit] = [.club, .diamond, .heart, .spade]
        
        for count in 2...max.rawValue {
            for cardSuit in suits {
                guard let rank = CardRank.init(rawValue: count),
                      let suit = CardSuit.init(rawValue: cardSuit.rawValue) else { return nil }
                let card = Card(rank: rank, suit: suit, state: .deck)
                cards.append(card)
            }
        }

        return cards.shuffle()
    }
    
}
