//
//  SheetPresentationController.swift
//
//
//  Created by El Mostafa El Ouatri on 16/02/24.
//

import SwiftUI
import UIKit

public struct SheetPresentationController<Content: View>: UIViewControllerRepresentable where Content: View {
    @Binding var isPresented: Bool
    let detents: [UISheetPresentationController.Detent]
    let prefersGrabberVisible: Bool
    let prefersScrollingExpandsWhenScrolledToEdge: Bool
    let preferredCornerRadius: CGFloat
    let additionalSafeAreaTop: CGFloat
    let largestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier?
    let backgroundColor: UIColor
    let onDismiss: (() -> Void)?
    let content: Content

    private let viewController = UIViewController()

    public init(
        isPresented: Binding<Bool>,
        detents: [UISheetPresentationController.Detent],
        prefersGrabberVisible: Bool,
        prefersScrollingExpandsWhenScrolledToEdge: Bool,
        preferredCornerRadius: CGFloat,
        additionalSafeAreaTop: CGFloat,
        largestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier?,
        backgroundColor: UIColor,
        onDismiss: (() -> Void)?,
        content: Content
    ) {
        self._isPresented = isPresented
        self.detents = detents
        self.prefersGrabberVisible = prefersGrabberVisible
        self.prefersScrollingExpandsWhenScrolledToEdge = prefersScrollingExpandsWhenScrolledToEdge
        self.preferredCornerRadius = preferredCornerRadius
        self.additionalSafeAreaTop = additionalSafeAreaTop
        self.largestUndimmedDetentIdentifier = largestUndimmedDetentIdentifier
        self.backgroundColor = backgroundColor
        self.onDismiss = onDismiss
        self.content = content
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    public func makeUIViewController(context: Context) -> UIViewController {
        viewController.view.backgroundColor = .clear
        return viewController
    }

    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        if isPresented {
            if uiViewController.presentedViewController == nil {
                uiViewController.additionalSafeAreaInsets.top = prefersGrabberVisible ? additionalSafeAreaTop : 0
                
                let sheetViewController = SheetHostingViewController(rootView: content, backgroundColor: backgroundColor)
                sheetViewController.sheetPresentationController?.delegate = context.coordinator
                sheetViewController.detents = detents
                sheetViewController.prefersGrabberVisible = prefersGrabberVisible
                sheetViewController.prefersScrollingExpandsWhenScrolledToEdge = prefersScrollingExpandsWhenScrolledToEdge
                sheetViewController.preferredCornerRadius = preferredCornerRadius
                sheetViewController.largestUndimmedDetentIdentifier = largestUndimmedDetentIdentifier
                sheetViewController.onDismiss = {
                    isPresented = false
                    onDismiss?()
                }

                uiViewController.present(sheetViewController, animated: true)
            }
        } else {
            uiViewController.presentedViewController?.dismiss(animated: true)
        }
    }

    public class Coordinator: NSObject, UISheetPresentationControllerDelegate {
        var parent: SheetPresentationController

        init(parent: SheetPresentationController) {
            self.parent = parent
        }

        public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            if self.parent.isPresented {
                self.parent.isPresented = false
                self.parent.onDismiss?()
            }
        }

    }
}

// MARK: - SheetHostingViewController

private class SheetHostingViewController<Content: View>: UIHostingController<Content> {

    var detents: [UISheetPresentationController.Detent] = [.medium(), .large()]
    var prefersGrabberVisible: Bool = true
    var prefersScrollingExpandsWhenScrolledToEdge: Bool = false
    var preferredCornerRadius: CGFloat = 20
    var largestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier?
    var backgroundColor: UIColor
    var additionalSafeAreaTop: CGFloat = 20
    var onDismiss: (() -> Void)? = nil
    
    init(rootView: Content, backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
        super.init(rootView: rootView)
    }

    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor

        if let sheetPresentationController = self.sheetPresentationController {
            sheetPresentationController.detents = detents
            sheetPresentationController.prefersGrabberVisible = prefersGrabberVisible
            sheetPresentationController.prefersScrollingExpandsWhenScrolledToEdge = prefersScrollingExpandsWhenScrolledToEdge
            sheetPresentationController.preferredCornerRadius = preferredCornerRadius
            sheetPresentationController.largestUndimmedDetentIdentifier = largestUndimmedDetentIdentifier
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.onDismiss?()
    }
}
