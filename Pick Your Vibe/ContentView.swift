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
        VibePickerView(viewModel: self.vibePickerViewModel)
    }
}

#Preview {
    ContentView()
}
