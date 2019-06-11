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

    init(dealer: Dealer = DealerUserCaseImpl()) {
        self.dealer = dealer
    }
    
    func deck() -> Deck {
        guard let deck = dealer.deal() else { return  Deck() }
        return deck
    }
}
