//
//  ContentView.swift
//  Pick Your Vibe
//
//  Created by Asaf Baibekov on 09/07/2025.
//

import SwiftUI
import WidgetKit

struct ContentView: View {

    @ObservedObject var vibePickerViewModel: VibePickerViewModel
    
    @State private var showVibePopup = false
    @State private var vibePopupViewModel: VibePopupViewModel?

    init() {
        let storable = UserDefaultsVibeStorable().eraseToAnyStorable()
        self.vibePickerViewModel = VibePickerViewModel(
            vibeStorable: storable,
            onSelectedVibeChanged: {
                WidgetCenter.shared.reloadTimelines(ofKind: "PickYourVibeWidget")
            }
        )
    }

    var body: some View {
        ZStack {
            VibePickerView(viewModel: self.vibePickerViewModel)
                .onOpenURL { url in
                    vibePopupViewModel = VibePopupViewModel(url: url)
                    showVibePopup = true
                }
            
            if showVibePopup, let vibePopupViewModel = vibePopupViewModel {
                VibePopupView(
                    vibePopupViewModel: vibePopupViewModel,
                    isPresented: $showVibePopup
                )
            }
        }
    }
}

#Preview {
    ContentView()
}
