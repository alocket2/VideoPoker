//
//  GameViewController.swift
//  Video Poker
//
//  Created by Anthony Lockett on 6/10/19.
//  Copyright © 2019 Anthony Lockett. All rights reserved.
//

import Foundation

final class PokerPresenter {
    
    var dealer: Dealer
    var currentDeck: Deck = []
    var currentHand: Deck = []
    var heldCards: Deck = []
    var discardedCards: Deck =  []
    
    init(dealer: Dealer = DealerUserCaseImpl()) {
        self.dealer = dealer
    }
    
    func deal() -> Deck {
        return getTopFive()
    }
    
    func discardAndGetNewCards() {
        currentHand = []
        getNewCards(numCards: discardedCards.count)
    }
    
    private func getNewCards(numCards: Int) {
        var newCards: [Card] = []
        for card in 0..<numCards {
            newCards.append(currentDeck[card])
        }

        currentHand = heldCards + newCards
    }
    
    private func getTopFive() -> Deck {
        guard let deck = dealer.deal() else { return  Deck() }
        currentDeck = deck
        var hand: [Card] = []
        for card in 0..<5 {
            hand.append(currentDeck[card])
            currentDeck.remove(at: card)
        }

        currentHand = hand
        return currentHand
    }
}
