//
//  VibesEntryView.swift
//  Pick Your Vibe
//
//  Created by Asaf Baibekov on 10/07/2025.
//

import SwiftUI

struct VibesEntryView: View {
    var entry: VibesProvider.Entry

    var body: some View {
        VStack(spacing: 8) {
            if let last = entry.vibes.last {
                Text(last.emoji)
                    .font(.system(size: 50))

                Text(last.label)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
            } else {
                Text("No vibe yet\nPick one!")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
            }
        }
    }
}
