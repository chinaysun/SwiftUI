//
//  Card.swift
//  MemoryCardGame
//
//  Created by Shawn Sun on 2/6/20.
//  Copyright © 2020 Shawn Sun. All rights reserved.
//
import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            cards.firstIndex(where: { $0.isFacingUp && !$0.isMatched })
        }
        set {
            cards.indices.forEach { cards[$0].isFacingUp = $0 == newValue }
        }
    }
    
    mutating func choose(card: Card) {
        if let index = cards.firstIndex(matching: card), !cards[index].isFacingUp, !cards[index].isMatched {
            if let lastFaceUpIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[index].content == cards[lastFaceUpIndex].content {
                    cards[index].isMatched = true
                    cards[lastFaceUpIndex].isMatched = true
                    cards[index].isFacingUp = true
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = index
                }
            } else {
                indexOfTheOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairs: Int, contentFactory: (Int) -> CardContent) {
        cards = []
        for index in 0..<numberOfPairs {
            cards.append(.init(isFacingUp: false, isMatched: false, content: contentFactory(index), id: index * 2))
            cards.append(.init(isFacingUp: false, isMatched: false, content: contentFactory(index), id: index * 2 + 1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFacingUp: Bool {
            didSet {
                if isFacingUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }

        var isMatched: Bool {
            didSet {
                stopUsingBonusTime()
            }
        }

        var content: CardContent
        var id: Int
        
        // MARK: - Bonus Time
        
        var bonusTimeLimit: TimeInterval = 6
        
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        var lastFaceUpDate: Date?
        var pastFaceUpTime: TimeInterval = 0
        
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
        }
        
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime: Bool {
            isFacingUp && !isMatched && bonusTimeRemaining > 0
        }
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
}
