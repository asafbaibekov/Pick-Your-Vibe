//
//  VibePickerViewModelProtocol.swift
//  Pick Your Vibe
//
//  Created by Asaf Baibekov on 09/07/2025.
//

import Foundation

protocol VibePickerViewModelProtocol: ObservableObject {
    
    var selectedVibe: Vibe? { get }
    
    var vibes: [Vibe] { get }
    
    func toggleSelection(for vibe: Vibe)
    
    func isSelected(_ vibe: Vibe) -> Bool
}
