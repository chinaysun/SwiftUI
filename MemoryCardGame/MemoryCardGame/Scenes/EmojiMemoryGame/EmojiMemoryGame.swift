//
//  EmojiMemoryGame.swift
//  MemoryCardGame
//
//  Created by Shawn Sun on 2/6/20.
//  Copyright © 2020 Shawn Sun. All rights reserved.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = createGame()
    
    static func createGame() -> MemoryGame<String> {
        let emojis: [String] = [.randomEmoji, .randomEmoji, .randomEmoji]
        return MemoryGame<String>(numberOfPairs: emojis.count) { emojis[$0] }
    }
    
    // MARK: - Access
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }

    func resetGame() {
        model = EmojiMemoryGame.createGame()
    }
}

private extension String {
    static var randomEmoji: String {
        let range = [UInt32](0x1F601...0x1F64F)
        let ascii = range[Int(drand48() * Double(range.count))]
        let emoji = UnicodeScalar(ascii)?.description
        return emoji!
    }
}
