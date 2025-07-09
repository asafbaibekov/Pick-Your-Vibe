//
//  ContentView.swift
//  Pick Your Vibe
//
//  Created by Asaf Baibekov on 09/07/2025.
//

import SwiftUI

struct ContentView: View {

    @StateObject var vibePickerViewModel = VibePickerViewModel()

    var body: some View {
        VibePickerView(viewModel: self.vibePickerViewModel)
    }
}

#Preview {
    ContentView()
}
