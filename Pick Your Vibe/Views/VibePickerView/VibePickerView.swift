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
        NavigationStack {
            GeometryReader { geometry in
                let isLandscape = geometry.size.width > geometry.size.height
                let columns = adaptiveColumns(
                    for: geometry.size,
                    isLandscape: isLandscape
                )
                
                VStack(spacing: 0) {
                    Text("Pick Your Vibe")
                        .font(.largeTitle)
                        .padding(.vertical, 8)

                    ScrollView {
                        LazyVGrid(columns: columns, spacing: spacing) {
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
                                .font(isLandscape ? .title3 : .title2)
                                .multilineTextAlignment(.center)
                                .transition(.opacity)
                        }
                        .padding(.vertical)
                    }
                }
            }
        }
    }
}

private extension VibePickerView {
    
    func adaptiveColumns(for size: CGSize, isLandscape: Bool) -> [GridItem] {
        let availableWidth = size.width - (spacing * 3)

        let minItemWidth: CGFloat = 120
        let maxItemWidth: CGFloat = 200

        if isLandscape {
            let columnsCount = max(2, min(6, Int(availableWidth / minItemWidth)))
            return Array(
                repeating: GridItem(
                    .flexible(
                        minimum: minItemWidth,
                        maximum: maxItemWidth
                    ),
                    spacing: spacing
                ),
                count: columnsCount
            )
        } else {
            return [
                GridItem(.flexible(minimum: minItemWidth, maximum: maxItemWidth), spacing: spacing),
                GridItem(.flexible(minimum: minItemWidth, maximum: maxItemWidth))
            ]
        }
    }
}

#Preview {
    let viewModel = VibePickerViewModel(
        vibeStorable: UserDefaultsVibeStorable().eraseToAnyStorable()
    )
    VibePickerView(viewModel: viewModel)
}
