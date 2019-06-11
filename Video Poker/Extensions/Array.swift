//
//  Array.swift
//  Video Poker
//
//  Created by Anthony Lockett on 6/10/19.
//  Copyright © 2019 Anthony Lockett. All rights reserved.
//

import Foundation

// Returns an array of shuffled cards
extension Array where Element == Card {

    mutating func shuffle() -> Deck {
        var shuffledDeck: Deck = []
        for _ in self {
            let random = Int(arc4random_uniform(UInt32(self.count - 1)))
            shuffledDeck.append(self[random])
            self.remove(at: random)
        }
        
        return shuffledDeck
    }
}
