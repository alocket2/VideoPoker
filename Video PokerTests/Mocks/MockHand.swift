//
//  MockDecks.swift
//  Video PokerTests
//
//  Created by Anthony Lockett on 6/11/19.
//  Copyright © 2019 Anthony Lockett. All rights reserved.
//

import Foundation
@testable import Video_Poker

class MockHand {
   static let straight = [Card(rank: .nine, suit: .club),
                              Card(rank: .queen, suit: .diamond),
                              Card(rank: .ace, suit: .spade),
                              Card(rank: .jack, suit: .diamond),
                              Card(rank: .king, suit: .spade)]
    static let double = [Card(rank: .nine, suit: .club),
                         Card(rank: .nine, suit: .diamond),
                         Card(rank: .ace, suit: .spade),
                         Card(rank: .jack, suit: .diamond),
                         Card(rank: .king, suit: .spade)]
}
