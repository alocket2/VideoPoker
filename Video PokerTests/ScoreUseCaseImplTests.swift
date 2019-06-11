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

    func testCheckForStraight() {
        let expected = true

        var isStraight: Bool = false
        let straightHand = MockDecks.straightDeck
        var sorted = straightHand.sort()
        for index in 0..<sorted.count {
            if index != sorted.count - 1 {
                if sorted[index + 1].rank.rawValue - sorted[index].rank.rawValue == 1 {
                    continue
                } else {
                    isStraight = false
                }
            }
        }

        isStraight = true

        XCTAssertEqual(isStraight, expected)
    }
}
