//
//  VibePickerView.swift
//  Pick Your Vibe
//
//  Created by Asaf Baibekov on 09/07/2025.
//


import SwiftUI

struct VibePickerView<ViewModel: VibePickerViewModelProtocol>: View {

    @ObservedObject var viewModel: ViewModel

    let spacing: CGFloat = 16

    var body: some View {
        NavigationView {
            VStack {
                Text("Pick Your Vibe")
                    .font(.largeTitle)
                    .padding(.top)

                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: spacing),
                        GridItem(.flexible())
                    ], spacing: spacing) {
                        ForEach(viewModel.vibes) { vibe in
                            VibeView(vibe: vibe, isSelected: viewModel.isSelected(vibe)) {
                                viewModel.toggleSelection(for: vibe)
                            }
                        }
                    }
                    .padding()
                }

                if let selected = viewModel.selectedVibe {
                    VStack(spacing: 8) {
                        Text("Your vibe today: \(selected.emoji) \(selected.label)!")
                            .font(.title2)
                            .transition(.opacity)
                    }
                    .padding(.top)
                }

                Spacer()
            }
        }
    }
}

#Preview {
    VibePickerView(viewModel: VibePickerViewModel(
        vibeStorable: UserDefaultsVibeStorable().eraseToAnyStorable()
    ))
}
