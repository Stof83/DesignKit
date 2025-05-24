//
//  View.swift
//  
//
//  Created by El Mostafa El Ouatri on 02/08/24.
//

import SwiftUI
import SkeletonUI

// MARK: - View Extension
public extension View {
    func sheet<Content>(
        isPresented: Binding<Bool>,
        detents: [UISheetPresentationController.Detent] = [.medium(), .large()],
        prefersGrabberVisible: Bool = true,
        prefersScrollingExpandsWhenScrolledToEdge: Bool = false,
        preferredCornerRadius: CGFloat = 20,
        additionalSafeAreaTop: CGFloat = 40,
        largestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier? = nil,
        backgroundColor: UIColor = .white,
        fitContent: Bool = false,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Content: View {
        return self.background(
            SheetPresentationController(
                isPresented: isPresented,
                detents: detents,
                prefersGrabberVisible: prefersGrabberVisible,
                prefersScrollingExpandsWhenScrolledToEdge: prefersScrollingExpandsWhenScrolledToEdge,
                preferredCornerRadius: preferredCornerRadius,
                additionalSafeAreaTop: additionalSafeAreaTop,
                largestUndimmedDetentIdentifier: largestUndimmedDetentIdentifier,
                backgroundColor: backgroundColor,
                onDismiss: onDismiss,
                content: content()
            )
        )
    }
}

struct SizeCalculator: ViewModifier {
    
    @Binding var size: CGSize
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            size = proxy.size
                        }
                }
            )
    }
}

public extension View {
    func saveSize(in size: Binding<CGSize>) -> some View {
        modifier(SizeCalculator(size: size))
    }
}

public extension View {
    @MainActor
    func defaultSkeleton(with loading: Bool, size: CGSize? = .none, shape: ShapeType = .capsule, lines: Int = 1) -> some View {
        skeleton(
            with: loading,
            size: size,
            animation: .pulse(autoreverses: false),
            appearance: .gradient(
                color: .softGray,
                background: .skeletonView,
                angle: .degrees(-45)
            ),
            shape: shape,
            lines: lines
        )
    }
}

// Extension to conditionally apply modifiers
public extension View {
    
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, content: (Self) -> Content) -> some View {
        if condition {
            content(self)
        } else {
            self
        }
    }

    /// Applies the given transform `transform` or `else`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    ///   - else: The transform that applies if `condition` is false
    /// - Returns: Either the original `View` or the modified `View` based on the condition`.
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content, @ViewBuilder else: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            `else`(self)
        }
    }
    
    /// Unwraps the given `value` and applies the given `transform`.
    /// - Parameters:
    ///   - value: The value to unwrap.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` with unwrapped `value` if the `value` is not nil`.
    @ViewBuilder
    func ifLet<Value, Content: View>(_ value: Value?, @ViewBuilder transform: (Value, Self) -> Content) -> some View {
        if let value = value {
            transform(value, self)
        } else {
            self
        }
    }
    
    /// Unwraps the given `value` and applies the given `transform`.
    /// - Parameters:
    ///   - value: The value to unwrap.
    ///   - transform: The transform to apply to the source `View`.
    ///   - else:The transform that applies if `value` is nil
    /// - Returns: Either the `else` transform or the modified `View` with unwrapped `value` if the `value` is not nil`.
    @ViewBuilder
    func ifLet<Value, Content: View>(_ value: Value?, @ViewBuilder transform: (Value, Self) -> Content, @ViewBuilder else: (Self) -> Content) -> some View {
        if let value = value {
            transform(value, self)
        } else {
            `else`(self)
        }
    }
    
    /// Applies a modifier if the iOS version is at least the given version
    @ViewBuilder
    func ifAvailable<Content: View>(iOS version: Int, @ViewBuilder transform: (Self) -> Content) -> some View {
        if isAvailable(iOS: version) {
            transform(self)
        } else {
            self
        }
    }

    /// Applies a modifier if the iOS version is lower than the given version
    @ViewBuilder
    func ifUnavailable<Content: View>(iOS version: Int, @ViewBuilder transform: (Self) -> Content) -> some View {
        if !isAvailable(iOS: version) {
            transform(self)
        } else {
            self
        }
    }
    
    /// Applies given transform to the view.
    /// - Parameters:
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Original `View`.
    @ViewBuilder
    func extractView<Content: View>(transform: (Self) -> Content) -> some View {
        transform(self)
    }
}

extension View {
    private func isAvailable(iOS: Int) -> Bool {
        let currentVersion = ProcessInfo.processInfo.operatingSystemVersion
        return currentVersion.majorVersion >= iOS
    }
}

struct EnvironmentObjectsModifier<T: ObservableObject>: ViewModifier {
    let objects: [T]

    init(_ objects: [T]) {
        self.objects = objects
    }

    func body(content: Content) -> some View {
        var result = AnyView(content)
        for object in objects {
            result = result.environmentObject(object) as! AnyView
        }
        return result
    }
}


public extension View {
    func environmentObjects<T: ObservableObject>(_ objects: T...) -> some View {
        self.modifier(EnvironmentObjectsModifier(objects))
    }

    func environmentObjects<T: ObservableObject>(_ objects: [T]) -> some View {
        self.modifier(EnvironmentObjectsModifier(objects))
    }
}

public extension View {
    func disable(_ disabled: Bool) -> some View {
        self.disabled(disabled).opacity(disabled ? 0.5 : 1)
    }

    func enabled(_ enabled: Bool) -> some View {
        self.disable(!enabled)
    }
}
