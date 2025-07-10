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
    
    func placeholder(in context: Context) -> VibesEntry {
        VibesEntry(date: .now, vibes: [])
    }

    func getSnapshot(in context: Context, completion: @escaping (VibesEntry) -> ()) {
        Task {
            let vibesEntry = try await {
                guard let vibes = try await self.vibeStorable.load() else {
                    return VibesEntry(date: .now, vibes: [])
                }
                return VibesEntry(date: Date(), vibes: vibes)
            }()
            completion(vibesEntry)
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            let vibes = try await self.vibeStorable.load() ?? []
            let fiveVibes = Array(vibes.prefix(5))
            let entry = VibesEntry(date: .now, vibes: fiveVibes)
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        }
    }
}
