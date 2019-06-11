//
//  ScoreUseCaseImplTestsd.swift
//  Video PokerTests
//
//  Created by Anthony Lockett on 6/11/19.
//  Copyright © 2019 Anthony Lockett. All rights reserved.
//

import XCTest
@testable import Video_Poker

class ScoreUseCaseImplTests: XCTestCase {
    
    func testTally() {
        let expectedStraightScore = 500
        let expectedDoubleScore = 100
        var score: Int = 0
        
        let straightHand = MockHand.straight.sort()
        let isStraight = checkForStraight(hand: straightHand)
        
        let doubleHand = MockHand.double.sort()
        let isDouble = checkForDouble(hand: doubleHand)
        
        if isStraight {
            score = 500
            XCTAssertEqual(score, expectedStraightScore)
        } else if isDouble {
            score = 100
            XCTAssertEqual(score, expectedDoubleScore)
        }
    }

    func testCheckForStraight() {
        let expected = true
        let straightHand = MockHand.straight.sort()
        let isStraight = checkForStraight(hand: straightHand)

        XCTAssertEqual(isStraight, expected)
    }
    
    func testForDouble() {
        let expected = true
        let doubleHand = MockHand.double.sort()
        let isDouble = checkForDouble(hand: doubleHand)
    
        XCTAssertEqual(isDouble, expected)
    }
}

extension ScoreUseCaseImplTests {
    private func checkForStraight(hand: Deck) -> Bool {
        for index in 0..<hand.count {
            if index != hand.count - 1 {
                if hand[index + 1].rank.rawValue - hand[index].rank.rawValue == 1 {
                    continue
                } else {
                    return false
                }
            }
        }
        
        return true
    }
    
    private func checkForDouble(hand: Deck) -> Bool {
        for index in 0..<hand.count {
            if index != hand.count - 1 {
                if hand[index + 1].rank.rawValue == hand[index].rank.rawValue {
                    return true
                } else {
                    continue
                }
            }
        }
        
        return false
    }
}
