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
    
    private let vibeStorable: AnyStorable<[Vibe]>

    let vibes: [Vibe] = [
        Vibe(emoji: "🧠", label: "Focus"),
        Vibe(emoji: "💪", label: "Power"),
        Vibe(emoji: "😴", label: "Chill"),
        Vibe(emoji: "😂", label: "Joy")
    ]
    
    init(vibeStorable: AnyStorable<[Vibe]>) {
        self.vibeStorable = vibeStorable
        Task { [weak self] in
            guard let self else { return }
            guard let savedVibes = try? await self.vibeStorable.load() else { return }
            await MainActor.run { [weak self] in
                guard let self else { return }
                guard let lastSavedVibe = savedVibes.last else { return }
                guard let matchingVibe = self.vibes.first(where: { $0.emoji == lastSavedVibe.emoji && $0.label == lastSavedVibe.label }) else { return }
                self.selectedVibe = matchingVibe
            }
        }
    }

    func toggleSelection(for vibe: Vibe) {
        self.selectedVibe = vibe
        Task { [weak self] in
            guard let self else { return }
            var savedVibes = (try? await self.vibeStorable.load()) ?? []
            if savedVibes.last != vibe {
                var vibe = vibe
                vibe.timestamp = Date()
                savedVibes.append(vibe)
                try? await self.vibeStorable.save(savedVibes)
            }
        }
    }

    func isSelected(_ vibe: Vibe) -> Bool {
        return selectedVibe?.id == vibe.id
    }
}
