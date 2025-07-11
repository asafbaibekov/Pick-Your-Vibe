//
//  SwingAnimationModifier.swift
//  Pick Your Vibe
//
//  Created by Asaf Baibekov on 11/07/2025.
//

import ClockHandRotationKit
import SwiftUI

/// A modifier that applies a swing animation to a view.
public struct SwingAnimationModifier: ViewModifier {

    public enum Direction: Hashable, Equatable {
        case horizontal
        case vertical
    }
    
    /// The duration of the animation.
    public let duration: CGFloat

    /// The direction of the swing animation.
    public let direction: Direction

    /// The distance of the swing animation.
    public let distance: CGFloat

    /// Creates a swing animation modifier with the specified duration, direction, and distance.
    /// - Parameters:
    ///   - duration: The duration of the animation.
    ///   - direction: The direction of the swing animation.
    ///   - distance: The distance of the swing animation.
    public init(duration: CGFloat, direction: Direction, distance: CGFloat) {
        self.duration = duration
        self.direction = direction
        self.distance = distance
    }

    private var alignment: Alignment {
        if direction == .vertical {
            return distance > 0 ? .top : .bottom
        } else {
            return distance > 0 ? .leading : .trailing
        }
    }

    @ViewBuilder
    private func overlayView(content: Content) -> some View {
        let alignment = alignment
        GeometryReader {
            let size = $0.size
            let extendLength = direction == .vertical ? size.height : size.width
            let length: CGFloat = abs(distance) + extendLength
            let innerDiameter = (length + extendLength) / 2
            let outerAlignment: Alignment = {
                if direction == .vertical {
                    return distance > 0 ? .bottom : .top
                } else {
                    return distance > 0 ? .trailing : .leading
                }
            }()

            ZStack(alignment: outerAlignment) {
                Color.clear
                ZStack(alignment: alignment) {
                    Color.clear
                    ZStack(alignment: alignment) {
                        Color.clear
                        content.clockHandRotationEffect(period: .custom(duration))
                    }
                    .frame(width: innerDiameter, height: innerDiameter)
                    .clockHandRotationEffect(period: .custom(-duration / 2))
                }
                .frame(width: length, height: length)
                .clockHandRotationEffect(period: .custom(duration))
            }
            .frame(width: size.width, height: size.height, alignment: alignment)
        }
    }

    public func body(content: Content) -> some View {
        content.hidden()
            .overlay(overlayView(content: content))
    }
}

public extension View {
    func swingAnimation(duration: CGFloat, direction: SwingAnimationModifier.Direction = .horizontal, distance: CGFloat) -> some View {
        modifier(SwingAnimationModifier(duration: duration, direction: direction, distance: distance))
    }
}
