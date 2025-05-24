//
//  ContentWebView.swift
//  ParkingKit
//
//  Created by El Mostafa El Ouatri on 02/03/25.
//

import SwiftUI

public struct ContentWebView: View {
    // MARK: - @Environment Properties
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Public Properties
    public var url: String
    public var title: String
    
    // MARK: - Body
    public var body: some View {
        NavigationView {
            WebView(url: url)
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden()
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image.iconBackPrimary
                        }
                    }
                }
        }
    }
}
