//
//  DialogAction.swift
//
//
//  Created by El Mostafa El Ouatri on 06/09/23.
//

/// A representation of an action button in a dialog.
public struct DialogAction {
    /// The title of the button.
    public let title: String
    
    /// The closure to be executed when the button is tapped.
    public let completion: (() -> Void)?
    
    /// Initializes a new instance of `DialogAction`.
    ///
    /// - Parameters:
    ///   - title: The title of the button.
    ///   - completion: The closure to be executed when the button is tapped. Default is `nil`.
    public init(title: String, completion: (() -> Void)? = nil) {
        self.title = title
        self.completion = completion
    }
}
