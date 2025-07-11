//
//  VibePopupView.swift
//  Pick Your Vibe
//
//  Created by GitHub Copilot on 12/07/2025.
//

import SwiftUI

struct VibePopupView: View {
    
    let vibePopupViewModel: VibePopupViewModel
    
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    isPresented = false
                }
            
            VStack(spacing: 16) {
                HStack {
                    Spacer()
                    Button(action: { isPresented = false }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.top, 16)
                .padding(.horizontal, 16)
                
                VStack(spacing: 16) {
                    Text(vibePopupViewModel.vibe.emoji)
                        .font(.system(size: 50))
                    
                    Text(vibePopupViewModel.vibe.label)
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.primary)
                    
                    Text("You've picked \(vibePopupViewModel.countThisWeek) vibes this week")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                    
                    Text("Your current vibe\nfrom the widget")
                        .lineLimit(2)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
            }
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.systemBackground))
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
            )
            .padding(.horizontal, 40)
            .frame(maxHeight: 300)
        }
        .animation(.easeInOut(duration: 0.3), value: isPresented)
    }
}

#Preview {
    VibePopupView(
        vibePopupViewModel: VibePopupViewModel(
            vibe: Vibe(emoji: "😂", label: "Joy"),
            countThisWeek: 5
        ),
        isPresented: .constant(true)
    )
}
