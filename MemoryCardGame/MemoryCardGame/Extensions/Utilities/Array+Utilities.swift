//
//  Array+Utilities.swift
//  MemoryCardGame
//
//  Created by Shawn Sun on 10/6/20.
//  Copyright © 2020 Shawn Sun. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    
    func firstIndex(matching: Element) -> Int? {
        self.firstIndex(where: { $0.id == matching.id})
    }
}
