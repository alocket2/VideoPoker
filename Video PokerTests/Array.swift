//
//  Array.swift
//  Video PokerTests
//
//  Created by Anthony Lockett on 6/11/19.
//  Copyright © 2019 Anthony Lockett. All rights reserved.
//

import Foundation
@testable import Video_Poker

extension Array where Element == Card {
    func sort() -> Deck {
        let sortedDeck = self.sorted {
            let rankOne = $0.rank.rawValue
            let rankTwo = $1.rank.rawValue
            return rankOne < rankTwo
        }
        
        return sortedDeck
    }
}
