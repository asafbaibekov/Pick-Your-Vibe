//
//  VibesEntryView.swift
//  Pick Your Vibe
//
//  Created by Asaf Baibekov on 10/07/2025.
//

import SwiftUI
import ClockHandRotationKit

struct VibesEntryView: View {
    var entry: VibesProvider.Entry

    var body: some View {
        VStack(spacing: 8) {
            if let vibe = entry.vibe {
                HStack {
                    if entry.countThisWeek?.isMultiple(of: 7) ?? false {
                        Text(vibe.emoji)
                            .font(.system(size: 36))
                            .offset(x: 0, y: -5)
                            .swingAnimation(duration: 2, direction: .vertical, distance: 10)
                    } else {
                        Text(vibe.emoji)
                            .font(.system(size: 36))
                    }
                    
                    Text(vibe.label)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                }
                
                
                
                if let countThisWeek = entry.countThisWeek {
                    Text("You’ve picked \(countThisWeek)\nvibes this week.")
                        .lineLimit(2)
                        .minimumScaleFactor(0.75)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        
                        .foregroundColor(.white)
                }
            } else {
                Text("No vibe yet\nPick one!")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
            }
        }
        .widgetURL(createWidgetURL())
    }
}

private extension VibesEntryView {
    
    func createWidgetURL() -> URL? {
        guard let vibe = entry.vibe else {
            return URL(string: "pickyourvibe://app")
        }
        
        var components = URLComponents()
        components.scheme = "pickyourvibe"
        components.host = "widget"
        components.queryItems = [
            URLQueryItem(name: "emoji", value: vibe.emoji),
            URLQueryItem(name: "label", value: vibe.label)
        ]
        
        if let countThisWeek = entry.countThisWeek {
            components.queryItems?.append(URLQueryItem(name: "count", value: String(countThisWeek)))
        }
        
        return components.url
    }
}
