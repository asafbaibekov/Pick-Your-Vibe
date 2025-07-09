//
//  Vibe.swift
//  Pick Your Vibe
//
//  Created by Asaf Baibekov on 09/07/2025.
//

import Foundation

struct Vibe: Identifiable, Codable {
    
    private(set) var id: UUID = UUID()
    
    let emoji: String
    
    let label: String
}
