//
//  VibePickerViewModel.swift
//  Pick Your Vibe
//
//  Created by Asaf Baibekov on 09/07/2025.
//

import Foundation
import SwiftUI

class VibePickerViewModel: VibePickerViewModelProtocol {
    
    @Published var selectedVibe: Vibe?

    let vibes: [Vibe] = [
        Vibe(emoji: "🧠", label: "Focus"),
        Vibe(emoji: "💪", label: "Power"),
        Vibe(emoji: "😴", label: "Chill"),
        Vibe(emoji: "😂", label: "Joy")
    ]

    func toggleSelection(for vibe: Vibe) {
        self.selectedVibe = self.isSelected(vibe) ? nil : vibe
    }

    func isSelected(_ vibe: Vibe) -> Bool {
        return selectedVibe?.id == vibe.id
    }
}
