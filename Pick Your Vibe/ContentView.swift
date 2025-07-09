//
//  ContentView.swift
//  Pick Your Vibe
//
//  Created by Asaf Baibekov on 09/07/2025.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var vibePickerViewModel: VibePickerViewModel

    init() {
        let storable = UserDefaultsVibeStorable().eraseToAnyStorable()
        self.vibePickerViewModel = VibePickerViewModel(vibeStorable: storable)
    }

    var body: some View {
        VibePickerView(viewModel: self.vibePickerViewModel)
    }
}

#Preview {
    ContentView()
}
