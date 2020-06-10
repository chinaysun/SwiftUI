//
//  Card.swift
//  MemoryCardGame
//
//  Created by Shawn Sun on 2/6/20.
//  Copyright © 2020 Shawn Sun. All rights reserved.
//

struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: [Card]

    var indexOfTheOneAndOnlyFaceUpCard: Int? {
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
    }

    struct Card: Identifiable {
        var isFacingUp: Bool
        var isMatched: Bool
        var content: CardContent
        var id: Int
    }
}
