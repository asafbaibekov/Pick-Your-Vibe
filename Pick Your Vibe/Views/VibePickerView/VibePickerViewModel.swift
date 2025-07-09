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
    
    private let vibeStorable: AnyStorable<Vibe>

    let vibes: [Vibe] = [
        Vibe(emoji: "🧠", label: "Focus"),
        Vibe(emoji: "💪", label: "Power"),
        Vibe(emoji: "😴", label: "Chill"),
        Vibe(emoji: "😂", label: "Joy")
    ]
    
    init(vibeStorable: AnyStorable<Vibe>) {
        self.vibeStorable = vibeStorable
        Task {
            guard let savedVibe = try? await self.vibeStorable.load() else { return }
            await MainActor.run {
                guard let matchingVibe = vibes.first(where: { $0.emoji == savedVibe.emoji && $0.label == savedVibe.label }) else { return }
                self.selectedVibe = matchingVibe
            }
        }
    }

    func toggleSelection(for vibe: Vibe) {
        self.selectedVibe = self.isSelected(vibe) ? nil : vibe
        guard let selectedVibe = self.selectedVibe else { return }
        Task {
            try? await self.vibeStorable.save(selectedVibe)
        }
    }

    func isSelected(_ vibe: Vibe) -> Bool {
        return selectedVibe?.id == vibe.id
    }
}
