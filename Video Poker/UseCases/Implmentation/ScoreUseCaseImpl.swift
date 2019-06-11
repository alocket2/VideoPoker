//
//  ScoreUseCaseImpl.swift
//  Video Poker
//
//  Created by Anthony Lockett on 6/11/19.
//  Copyright © 2019 Anthony Lockett. All rights reserved.
//

import Foundation

class ScoreUseCaseImpl: Score {
    func tally(hand: Deck) -> Int {
        let sorted = hand.sort()
        let isStraight = checkForStraight(hand: sorted)
        let isDouble = checkForDouble(hand: sorted)
        
        if isStraight {
            return 500
        } else if isDouble {
            return 100
        }

        return 0
    }
}

extension ScoreUseCaseImpl {
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
