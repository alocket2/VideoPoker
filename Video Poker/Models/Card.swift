//
//  Card.swift
//  Video Poker
//
//  Created by Anthony Lockett on 6/10/19.
//  Copyright © 2019 Anthony Lockett. All rights reserved.
//

import Foundation

enum CardRank: Int {
    case two = 2, three, four, five, six, seven, eight, nine, jack, queen, king, ace
    
    func description() -> String {
        switch self {
            case .jack:
                return "Jack"
            case .queen:
                return "Queen"
            case .king:
                return "King"
            case .ace:
                return "Ace"
            default:
                return String(self.rawValue)
        }
    }

}

enum CardSuit: String {
    case club
    case diamond
    case heart
    case spade
}

struct Card {
    var rank: CardRank
    var suit: CardSuit
}
