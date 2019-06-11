//
//  DeckUseCaseImpl.swift
//  Video Poker
//
//  Created by Anthony Lockett on 6/10/19.
//  Copyright © 2019 Anthony Lockett. All rights reserved.
//

import Foundation

final class DealerUserCaseImpl: Dealer {

    func shuffle(deck: inout Deck) -> Deck {
        return deck.shuffle()
    }

    func deal() -> Deck? {
        guard let deck = generate() else { return nil }
        return deck
    }

}

// MARK: - Private functions
extension DealerUserCaseImpl {
    /**
     Generates a deck of cards
     Run time O^2 - Could get better potentially.
     
     - Returns: A shuffled deck of cards
     */
    
    private func generate() -> Deck? {
        var cards = [Card]()
        let suits: [CardSuit] = [.club, .diamond, .heart, .spade]
        
        for count in 2...CardRank.ace.rawValue {
            for cardSuit in suits {
                guard let rank = CardRank.init(rawValue: count),
                    let suit = CardSuit.init(rawValue: cardSuit.rawValue) else { return nil }
                let card = Card(rank: rank, suit: suit)
                cards.append(card)
            }
        }

        return cards.shuffle()
    }
}

