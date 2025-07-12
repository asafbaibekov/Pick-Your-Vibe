//
//  VibeView.swift
//  Pick Your Vibe
//
//  Created by Asaf Baibekov on 09/07/2025.
//

import SwiftUI

struct VibeView: View {
    
    let vibe: Vibe
    
    let isSelected: Bool
    
    private(set) var onTap: (() -> Void)? = nil

    var body: some View {
        GeometryReader { geometry in
            let side = min(geometry.size.width, geometry.size.height)
            
            let emojiSize: CGFloat = min(50, side * 0.3)
            let labelSize: CGFloat = min(24, side * 0.15)
            
            VStack(spacing: 8) {
                Text(vibe.emoji)
                    .font(.system(size: emojiSize))

                Text(vibe.label)
                    .font(.system(size: labelSize, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)
            }
            .frame(width: side, height: side)
            .background(Color.blue.opacity(0.3))
            .clipShape(RoundedRectangle(cornerRadius: min(16, side * 0.1)))
            .overlay(
                RoundedRectangle(cornerRadius: min(16, side * 0.1))
                    .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 3)
            )
            .bounceOnTap(onTap)
            .animation(.easeInOut(duration: 0.1), value: isSelected)
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

#Preview("Portrait", traits: .portrait) {
    @Previewable @State var isSelected = true
    let vibe = Vibe(emoji: "😂", label: "Joy")

    VStack {
        VibeView(vibe: vibe, isSelected: isSelected) {
            isSelected.toggle()
        }
        .frame(width: 100)
        .padding(.vertical, 24)
        
        VibeView(vibe: vibe, isSelected: isSelected) {
            isSelected.toggle()
        }
        .frame(width: 130)
        .padding(.vertical, 24)
        
        VibeView(vibe: vibe, isSelected: isSelected) {
            isSelected.toggle()
        }
        .padding(.vertical, 24)
    }
}

#Preview("LandscapeLeft", traits: .landscapeLeft) {
    @Previewable @State var isSelected = true
    let vibe = Vibe(emoji: "😂", label: "Joy")

    HStack {
        VibeView(vibe: vibe, isSelected: isSelected) {
            isSelected.toggle()
        }
        .frame(width: 100)
        .padding(.vertical, 24)
        
        VibeView(vibe: vibe, isSelected: isSelected) {
            isSelected.toggle()
        }
        .frame(width: 130)
        .padding(.vertical, 24)
        
        VibeView(vibe: vibe, isSelected: isSelected) {
            isSelected.toggle()
        }
        .padding(.vertical, 24)
    }
}
