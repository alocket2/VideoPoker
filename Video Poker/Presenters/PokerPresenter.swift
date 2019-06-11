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
    var currentHand: Deck = []
    var heldCards: Deck = []

    init(dealer: Dealer = DealerUserCaseImpl()) {
        self.dealer = dealer
    }
    
    func deal() -> Deck {
        return getTopFive()
    }
    
    func discardAndGetNewCards() {
        getNewCards(numCards: currentHand.count)
    }
    
    private func getNewCards(numCards: Int) {
        guard let deck = dealer.deal() else { return }
        var newCards: [Card] = []
        for card in 0..<numCards {
            newCards.append(deck[card])
        }
        
        currentHand = []
        currentHand = heldCards + newCards
    }
    
    private func getTopFive() -> Deck {
        guard let deck = dealer.deal() else { return  Deck() }
        var hand: [Card] = []
        for card in 0..<5 {
            hand.append(deck[card])
        }
        currentHand = hand
        return currentHand
    }
}
