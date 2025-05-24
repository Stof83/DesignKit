//
//  UIViewController.swift
//  
//
//  Created by El Mostafa El Ouatri on 03/08/23.
//

import SwiftUI
import UIKit
import UtilitiesKit

extension UIViewController {
    /// Presents the view with the specified root view and presentation mode.
    ///
    /// - Parameters:
    ///   - rootView: The root view to be presented.
    ///   - mode: The presentation mode to be used.
    ///   - completion: A closure to be called when the view presentation is completed.
    public func present<RootView: View>(
        with rootView: RootView,
        mode: PresentationType,
        isNavigationBarHidden: Bool = false,
        hidesBottomBarWhenPushed: Bool = true,
        backgroundColor: UIColor = .white,
        completion: @escaping () -> Void
    ) {
        DispatchQueue.main.async {
            let viewController = UIHostingController(rootView: rootView)
            viewController.view.backgroundColor = backgroundColor
            viewController.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed
            
            switch mode {
                case .modal, .full:
                    viewController.modalPresentationStyle = .fullScreen
                    viewController.modalTransitionStyle = .coverVertical
                    self.present(viewController, animated: true, completion: completion)
                    
                case .push:
                    let navigationController = self.navigationController ?? UINavigationController(rootViewController: self)
                    navigationController.isNavigationBarHidden = isNavigationBarHidden
                    navigationController.pushViewController(viewController, animated: true)
                    completion()
            }
        }
    }
}

