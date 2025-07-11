//
//  BounceViewModifier.swift
//  Pick Your Vibe
//
//  Created by Asaf Baibekov on 11/07/2025.
//

import SwiftUI

struct BounceViewModifier: ViewModifier {

    struct BounceConfig {
        var pressScale: CGFloat = 0.9
        var pressDuration: Double = 0.25
        var releaseDuration: Double = 0.25
        var releaseExtraBounce: Double = 0.4

        static let `default` = BounceConfig()
    }

    var config: BounceConfig

    var tapping: Binding<Bool>?

    var onTap: (() -> Void)?

    @State private var internalTapping = false

    func body(content: Content) -> some View {
        content
            .scaleEffect(internalTapping ? config.pressScale : 1)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        withAnimation(.smooth(duration: config.pressDuration)) {
                            internalTapping = true
                        }
                        tapping?.wrappedValue = true
                    }
                    .onEnded { _ in
                        withAnimation(.bouncy(duration: config.releaseDuration, extraBounce: config.releaseExtraBounce)) {
                            internalTapping = false
                        }
                        tapping?.wrappedValue = false
                        onTap?()
                    }
            )
    }
}

extension View {
    func bounceOnTap(config: BounceViewModifier.BounceConfig = .default, tapping: Binding<Bool>? = nil, _ onTap: (() -> Void)? = nil) -> some View {
        self.modifier(BounceViewModifier(config: config, tapping: tapping, onTap: onTap))
    }
}
