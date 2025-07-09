//
//  Vibe.swift
//  Pick Your Vibe
//
//  Created by Asaf Baibekov on 09/07/2025.
//

import Foundation

struct Vibe: Identifiable, Codable, Equatable {
    
    private(set) var id: UUID = UUID()
    
    let emoji: String
    
    let label: String
    
    var timestamp: Date = Date()
    
    static func == (lhs: Vibe, rhs: Vibe) -> Bool {
        return lhs.emoji == rhs.emoji && lhs.label == rhs.label
    }
}
