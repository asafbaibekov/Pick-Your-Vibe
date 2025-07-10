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
        VibeEntry(date: .now, vibe: nil)
    }

    func getSnapshot(in context: Context, completion: @escaping (VibeEntry) -> ()) {
        Task {
            let vibe = try await self.vibeStorable.load()?.last
            let vibesEntry = VibeEntry(date: .now, vibe: vibe)
            completion(vibesEntry)
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            let vibe = try await self.vibeStorable.load()?.last
            let entry = VibeEntry(date: .now, vibe: vibe)
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        }
    }
}
