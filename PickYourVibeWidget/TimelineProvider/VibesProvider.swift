//
//  VibesProvider.swift
//  Pick Your Vibe
//
//  Created by Asaf Baibekov on 10/07/2025.
//

import WidgetKit

struct VibesProvider: TimelineProvider {
    
    let vibeStorable: AnyStorable<[Vibe]>
    
    init(vibeStorable: AnyStorable<[Vibe]>) {
        self.vibeStorable = vibeStorable
    }
    
    func placeholder(in context: Context) -> VibeEntry {
        VibeEntry(date: .now, vibe: nil, countThisWeek: nil)
    }

    func getSnapshot(in context: Context, completion: @escaping (VibeEntry) -> ()) {
        Task {
            let vibes = try await self.vibeStorable.load() ?? []
            let filteredForThisWeek = self.vibesThisWeek(vibes)
            let vibesEntry = VibeEntry(date: .now, vibe: filteredForThisWeek.last, countThisWeek: filteredForThisWeek.count)
            completion(vibesEntry)
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            let vibes = try await self.vibeStorable.load() ?? []
            let filteredForThisWeek = self.vibesThisWeek(vibes)
            let entry = VibeEntry(date: .now, vibe: filteredForThisWeek.last, countThisWeek: filteredForThisWeek.count)
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        }
    }
}

private extension VibesProvider {

    func vibesThisWeek(_ vibes: [Vibe]) -> [Vibe] {
        let calendar = Calendar.current
        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())) else { return [] }
        return vibes.filter { $0.timestamp >= startOfWeek }
    }
}
