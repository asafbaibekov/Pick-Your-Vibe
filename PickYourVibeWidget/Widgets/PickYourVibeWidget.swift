//
//  PickYourVibeWidget.swift
//  PickYourVibeWidget
//
//  Created by Asaf Baibekov on 10/07/2025.
//

import WidgetKit
import SwiftUI

struct PickYourVibeWidget: Widget {
    let kind: String = "PickYourVibeWidget"

    let vibeStorable = UserDefaultsVibeStorable().eraseToAnyStorable()

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: VibesProvider(vibeStorable: vibeStorable)) { entry in
            if #available(iOS 17.0, *) {
                VibesEntryView(entry: entry)
                    .containerBackground(.blue.opacity(0.3), for: .widget)
            } else {
                VibesEntryView(entry: entry)
                    .background(Color.blue.opacity(0.3))
            }
        }
        .configurationDisplayName("My Vibe")
        .description("Shows your current picked vibe.")
    }
}

#Preview(
    as: .systemSmall,
    widget: {
        PickYourVibeWidget()
    },
    timeline: {
        VibesEntry(date: .now, vibes: [Vibe(emoji: "😂", label: "Joy")])
        VibesEntry(date: .now, vibes: [])
    }
)
