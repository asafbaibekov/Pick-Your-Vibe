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
            let side = geometry.size.width

            VStack(spacing: 8) {
                Text(vibe.emoji)
                    .font(.system(size: 50))

                Text(vibe.label)
                    .font(.headline)
                    .foregroundColor(.white)
            }
            .frame(width: side, height: side)
            .background(Color.blue.opacity(0.3))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 3)
            )
            .onTapGesture {
                withAnimation {
                    onTap?()
                }
            }
            .animation(.easeInOut(duration: 0.1), value: isSelected)
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    @Previewable @State var isSelected = true
    let vibe = Vibe(emoji: "😂", label: "Joy")

    VibeView(vibe: vibe, isSelected: isSelected) {
        isSelected.toggle()
    }
    .padding(24)
}
