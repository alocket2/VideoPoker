//
//  GameViewController.swift
//  Video Poker
//
//  Created by Anthony Lockett on 6/10/19.
//  Copyright © 2019 Anthony Lockett. All rights reserved.
//

import Foundation

final class PokerPresenter {
    
    //MARK: - Varibales
    var dealer: Dealer
    var scorer: Score
    var currentDeck: Deck = []
    var currentHand: Deck = []
    var heldCards: Deck = []
    var discardedCards: Deck =  []
    
    init(dealer: Dealer = DealerUserCaseImpl(),
         scorer: Score = ScoreUseCaseImpl()) {
        self.dealer = dealer
        self.scorer = scorer
    }

    func resetGame() {
        currentDeck = []
        currentHand = []
        heldCards = []
        discardedCards = []
    }
    
    /*
      Returns a new shuffled deck from the dealer
    */
    func deal() -> Deck {
        return getTopFive()
    }
    
    /*
     Empties the current hand and draws the same amount of cards as the discarded
    */
    func discardAndGetNewCards() {
        if discardedCards.count > 0 {
            currentHand = []
            getNewCards(numCards: discardedCards.count)
        }
    }
    
    func score() -> Int {
        return scorer.tally(hand: currentHand)
    }
    
    /*
     numCards: The amount of cards to get from the current deck
     
     Combines the new cards obtained from the deck and the held cards into
     the current hand
    */
    private func getNewCards(numCards: Int) {
        var newCards: [Card] = []
        for card in 0..<numCards {
            newCards.append(currentDeck[card])
            currentDeck.remove(at: card)
        }

        currentHand = heldCards + newCards
    }
    
    /*
     Returns the initial top five cards of the current deck
    */
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
