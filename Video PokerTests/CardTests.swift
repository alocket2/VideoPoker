//
//  CardTests.swift
//  Video PokerTests
//
//  Created by Anthony Lockett on 6/11/19.
//  Copyright © 2019 Anthony Lockett. All rights reserved.
//

import XCTest
@testable import Video_Poker

class CardTests: XCTestCase {
    
    func testDescription() {
        let jExpected = "Jack"
        let qExpected = "Queen"
        let kExtected = "King"
        let aExpected = "Ace"
        
        let numExpected = "6"
        
        let jCard = Card(rank: .jack, suit: .club)
        let qCard = Card(rank: .queen, suit: .club)
        let kCard = Card(rank: .king, suit: .club)
        let aCard = Card(rank: .ace, suit: .club)
        let sixCard = Card(rank: .six, suit: .club)
        
        XCTAssertEqual(jCard.rank.description(), jExpected)
        XCTAssertEqual(qCard.rank.description(), qExpected)
        XCTAssertEqual(kCard.rank.description(), kExtected)
        XCTAssertEqual(aCard.rank.description(), aExpected)
        XCTAssertEqual(sixCard.rank.description(), numExpected)
    }
    
    
    
    

}
