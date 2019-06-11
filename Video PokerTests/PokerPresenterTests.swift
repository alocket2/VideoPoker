//
//  DeckManagerTests.swift
//  Video PokerTests
//
//  Created by Anthony Lockett on 6/10/19.
//  Copyright © 2019 Anthony Lockett. All rights reserved.
//

import XCTest
@testable import Video_Poker

class PokerPresenterTests: XCTestCase {
    
    var dealer: Dealer!
    var deck: Deck!
    var currentHand: Deck = []
    
    override func setUp() {
        dealer = DealerUserCaseImpl()
        deck = dealer.deal()
    }
    
    override func tearDown() {
        dealer = nil
        deck = nil
    }
    
    func testDeal() {
        testGetTopFive()
    }

    func testGetNewCards() {
        let newCardAmount = 5
        var newCards: [Card] = []
        for card in 0..<newCardAmount {
            newCards.append(deck[card])
        }
        
        currentHand = newCards
        XCTAssertEqual(newCards.count, newCardAmount)
    }
    
    func testGetTopFive() {

        let expectedAmount = 5

        var hand: [Card] = []
        for card in 0..<5 {
            hand.append(deck[card])
        }
        currentHand = hand
        XCTAssertEqual(hand.count, expectedAmount)
        
    }
    
}
