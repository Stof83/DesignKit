//
//  Text.swift
//
//
//  Created by El Mostafa El Ouatri on 04/07/24.
//

import SwiftUI

extension Text {
    public init(html: String) {
        self.init(html.htmlToMarkdown())
    }
}
