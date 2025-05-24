//
//  CountdownView.swift
//
//
//  Created by El Mostafa El Ouatri on 28/06/23.
//

import SwiftUI
import UtilitiesKit

    /// A view that displays a countdown to a target date.
    public struct CountdownView<Content: View, ColonContent: View>: View {
        
        // MARK: - @State Properties
        
        /// The remaining time in seconds.
        @State private var remainingTime: TimeInterval
        
        /// Flag to determine whether colons should be hidden between time units.
        @State private var isColonHidden: Bool = false  // Default is false
        
        
        // MARK: - Private Properties

        /// The target date to count down to.
        public let targetDate: Date
        
        /// The spacing between the time units in the countdown.
        public var spacing: CGFloat
        
        /// A closure that returns a custom view for each time unit.
        public let content: (String, String) -> Content
        
        /// A closure to customize the colon view.
        public let colon: (Int) -> ColonContent
        
        /// A closure that gets called when the countdown ends.
        private var onEnded: (() -> Void)?
        
        /// A timer that publishes every second to update the countdown.
        private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

        private var days: String { String(format: "%02d", Int(remainingTime) / 86400) }
        private var hours: String { String(format: "%02d", (Int(remainingTime) % 86400) / 3600) }
        private var minutes: String { String(format: "%02d", (Int(remainingTime) % 3600) / 60) }
        private var seconds: String { String(format: "%02d", Int(remainingTime) % 60) }
        
        // MARK: - Initializer
        
        /// Initializes the countdown view with the target date, content view builder, and colon view builder.
        /// - Parameters:
        ///   - targetDate: The target date to count down to.
        ///   - spacing: The spacing between time units.
        ///   - content: A view builder closure to customize the time unit display.
        ///   - colon: A view builder closure to customize the colon between time units.
        public init(
            from targetDate: Date,
            spacing: CGFloat = 10,
            @ViewBuilder content: @escaping (String, String) -> Content = { value, label in
                VStack {
                    Text(value)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(minWidth: 60)
                        .transition(.opacity)
                    
                    Text(label)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            },
            @ViewBuilder colon: @escaping (Int) -> ColonContent = { _ in
                Text(":")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
        ) {
            self.targetDate = targetDate
            self.spacing = spacing
            self.content = content
            self.colon = colon
            _remainingTime = State(initialValue: max(targetDate.timeIntervalSinceNow, 0))
        }
        
        // MARK: - Body
        
        public var body: some View {
            VStack {
                if remainingTime > 24 * 3600 {
                    countdownRow(values: [(days, L10n.days), (hours, L10n.hours), (minutes, L10n.minutes)])
                } else {
                    countdownRow(values: [(hours, L10n.hours), (minutes, L10n.minutes), (seconds, L10n.seconds)])
                }
            }
            .onReceive(timer) { _ in
                if remainingTime > 0 {
                    withAnimation {
                        remainingTime = max(targetDate.timeIntervalSinceNow, 0)
                        if remainingTime == 0 {
                            onEnded?()
                        }
                    }
                    
                }
            }
        }
        
        // MARK: - Private Methods
        
        /// Creates a countdown row for the specified time units.
        private func countdownRow(values: [(String, String)]) -> some View {
            HStack(alignment: .top, spacing: spacing) {
                ForEach(values.indices, id: \ .self) { index in
                    content(values[index].0, values[index].1)
                    
                    // Only show colon if it's not hidden and it's not the last value
                    if !isColonHidden && index < values.count - 1 {
                        colon(index)
                    }
                }
            }
        }
        
        // MARK: - Modifiers
        
        /// Sets a closure to be executed when the countdown ends.
        public func onEnd(perform action: (() -> Void)? = nil) -> some View {
            var copy = self
            copy.onEnded = action
            return copy
        }
    }

    // MARK: - Preview

    public struct CountdownView_Previews: PreviewProvider {
        public static var previews: some View {
            CountdownView(from: Date().addingTimeInterval(3661))  // Example: 1 hour, 1 minute, 1 second
                .onEnd {
                    print("Countdown ended!")
                }
        }
    }
