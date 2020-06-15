//
//  Grid.swift
//  MemoryCardGame
//
//  Created by Shawn Sun on 10/6/20.
//  Copyright © 2020 Shawn Sun. All rights reserved.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    var items: [Item]
    var viewForItem: (Item) -> ItemView

    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }

    var body: some View {
        GeometryReader { self.body(for: GridLayout(itemCount: self.items.count, in: $0.size)) }
    }

    func body(for layout: GridLayout) -> some View {
        ForEach(items) { item in
            self.items.firstIndex(matching: item).map {
                self.viewForItem(item)
                    .frame(width: layout.itemSize.width, height: layout.itemSize.height)
                    .position(layout.location(ofItemAt: $0))
            }
        }
    }
}
