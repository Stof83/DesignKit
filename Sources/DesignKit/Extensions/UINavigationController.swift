//
//  UINavigationController.swift
//
//
//  Created by El Mostafa El Ouatri on 30/06/23.
//

import UIKit

extension UINavigationController {

    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        navigationBar.topItem?.backButtonDisplayMode = .minimal
    }

}
