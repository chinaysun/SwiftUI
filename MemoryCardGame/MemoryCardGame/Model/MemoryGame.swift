//
//  Card.swift
//  MemoryCardGame
//
//  Created by Shawn Sun on 2/6/20.
//  Copyright © 2020 Shawn Sun. All rights reserved.
//

struct MemoryGame<CardContent> {
    var cards: [Card]

    mutating func choose(card: Card) {
        guard let index = cards.firstIndex(where: { card.id == $0.id }) else { return }
        cards[index].isFacingUp.toggle()
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
