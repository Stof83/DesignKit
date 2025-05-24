//
//  WebView.swift
//  
//
//  Created by El Mostafa El Ouatri on 19/06/23.
//

import SwiftUI
import UIKit
import WebKit

/// A SwiftUI view that displays a web view using `WKWebView`.
///
/// The `WebView` allows you to load and display web content inside your SwiftUI app.
/// You can set the URL to load and optionally provide query parameters as `queryItems`.
/// Additionally, you can customize the appearance by setting the theme's brand color for the progress view.
///
/// Example usage:
/// ```
/// let urlString = "https://www.example.com"
/// let queryItems: [String: String] = ["key1": "value1", "key2": "value2"]
/// let webView = WebView(url: urlString, queryItems: queryItems)
/// ```
public struct WebView: UIViewRepresentable {
    
    // MARK: - Public Properties
    
    /// The URL to load in the web view.
    public let url: String?
    
    /// Query parameters to be appended to the URL as query items.
    public let queryItems: [String: String]
    
    // MARK: - Initialize
    
    /// Initializes a new `WebView`.
    ///
    /// - Parameters:
    ///   - url: The URL to load in the web view.
    ///   - queryItems: Query parameters to be appended to the URL as query items. Default is an empty dictionary.
    public init(url: String?, queryItems: [String: String] = [:]) {
        self.url = url
        self.queryItems = queryItems
    }
    
    // MARK: - UIViewRepresentable
    
    /// Creates and configures the underlying UIKit view for the web view.
    public func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        
        return webView
    }
    
    /// Updates the view represented by this object.
    public func updateUIView(_ webView: WKWebView, context: Context) {
        guard let url else { return }
        
        var urlComponents = URLComponents(string: url)

        var existingQueryItems = urlComponents?.queryItems ?? []
        existingQueryItems.append(contentsOf: queryItems.map { URLQueryItem(name: $0, value: $1) })

        urlComponents?.queryItems = existingQueryItems

        if let url = urlComponents?.url {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    /// Creates a coordinator to coordinate with the web view.
    public func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    // MARK: - Coordinator
    
    /// A coordinator for handling navigation and progress updates of the web view.
    public class Coordinator: NSObject, WKNavigationDelegate {
        
        let progressView = UIProgressView(progressViewStyle: .default)
        var webView: WKWebView?

        public override init() {
            super.init()
            
            let brandColor = ThemeManager.shared.colors.brand
            
            progressView.observedProgress = Progress(totalUnitCount: 100)
            progressView.sizeToFit()
            progressView.tintColor = brandColor.color.toUIColor
        }

        public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            webView.addSubview(progressView)

            progressView.translatesAutoresizingMaskIntoConstraints = false
            webView.removeConstraints(webView.constraints)
            webView.addConstraints([
                progressView.topAnchor.constraint(equalTo: webView.topAnchor, constant: webView.scrollView.contentOffset.y * -1),
                progressView.leadingAnchor.constraint(equalTo: webView.leadingAnchor),
                progressView.trailingAnchor.constraint(equalTo: webView.trailingAnchor),
            ])

            progressView.isHidden = false

            self.webView = webView
            webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        }

        public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            progressView.isHidden = true
            removeObserver()

            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                webView.evaluateJavaScript("document.getElementsByTagName('mv-download-app-partners-banner')[0].style.display = 'none';")
            }
            
        }

        public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            progressView.isHidden = true
            removeObserver()
        }

        func removeObserver() {
            if let webView = self.webView {
                webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
                self.webView = nil
            }
        }

        public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
            if keyPath == #keyPath(WKWebView.estimatedProgress),
               let webView = object as? WKWebView {
                let estimatedProgress = webView.estimatedProgress
                progressView.observedProgress?.completedUnitCount = Int64(estimatedProgress * 100)
            }
        }
    }

}
