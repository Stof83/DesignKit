//
//  WebViewLinkView.swift
//  
//
//  Created by El Mostafa El Ouatri on 19/06/23.
//

import SwiftUI

/// A SwiftUI view that combines a `WebView` with a `NavigationLink` and an `ItemView`.
///
/// The `WebViewLinkView` creates a link to a web view when tapped and displays the specified image and text as an `ItemView`.
/// It is commonly used in lists or grid-based layouts where each item has an associated link to open a web page.
///
/// Example usage:
/// ```
/// let text = "Explore More"
/// let title = "Web Page"
/// let image = Image(systemName: "globe")
/// let urlString = "https://www.example.com"
/// let queryItems: [String: String] = ["key1": "value1", "key2": "value2"]
/// let webViewLinkView = WebViewLinkView(text: text, title: title, image: image, url: urlString, queryItems: queryItems)
/// ```
public struct WebViewLinkView: View {
    
    // MARK: - Public Properties
    
    /// The text to display in the associated `ItemView`.
    public var text: String
    
    /// The navigation title for the web view.
    public var title: String
    
    /// The image to display in the associated `ItemView`.
    public var image: Image
    
    /// The URL to load in the web view.
    public var url: String?
    
    /// Query parameters to be appended to the URL as query items.
    public var queryItems: [String: String]
    
    // MARK: - Initialize
    
    /// Initializes a new `WebViewLinkView`.
    ///
    /// - Parameters:
    ///   - text: The text to display in the associated `ItemView`.
    ///   - title: The navigation title for the web view.
    ///   - image: The image to display in the associated `ItemView`.
    ///   - url: The URL to load in the web view. Default is `nil`.
    ///   - queryItems: Query parameters to be appended to the URL as query items. Default is an empty dictionary.
    public init(text: String, title: String, image: Image, url: String? = nil, queryItems: [String: String] = [:]) {
        self.text = text
        self.title = title
        self.image = image
        self.url = url
        self.queryItems = queryItems
    }
    
    // MARK: - Body
    
    public var body: some View {
        NavigationLink {
            WebView(url: url, queryItems: queryItems)
                .ignoresSafeArea()
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(.inline)
        } label: {
            ItemView(image: image, text: text)
        }
        .isHidden(url.isNilOrEmpty)
    }
}


struct WebViewLinkView_Previews: PreviewProvider {
    static var previews: some View {
        return NavigationView {
            WebViewLinkView(text: "Link", title: "Link", image: Image.iconBus, url: "www.wetaxi.it")
        }
    }
}
