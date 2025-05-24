//
//  LottieView.swift
//
//
//  Created by El Mostafa El Ouatri on 29/06/23.
//

import SwiftUI
import Lottie

/// A SwiftUI view that displays Lottie animations.
public struct LottieView: UIViewRepresentable {
    
    /// The type of loading for the Lottie animation.
    public enum LoadingType {
        /// Load the animation from a URL.
        case url(URL)
        /// Load the animation from a file name.
        case name(String)
        /// Load the animation from a file path.
        case filePath(String)
        /// Use a preloaded LottieAnimation object for the animation.
        case animation(LottieAnimation)
    }
    
    // MARK: - Public Properties
    
    /// Flag to control the animation playback.
    @Binding var play: Bool

    /// The type of loading for the Lottie animation.
    public let type: LoadingType
    
    /// The loop mode for the Lottie animation.
    public let loopMode: LottieLoopMode
    
    // MARK: - Private Properties
    
    /// The Lottie animation view.
    private let animationView = LottieAnimationView()

    /// Initializes a LottieView with the specified loading type and play binding.
    /// - Parameters:
    ///   - type: The type of loading for the Lottie animation.
    ///   - loopMode: The loop mode for the Lottie animation. Default is `.loop`.
    ///   - play: The binding to control the animation playback. Default is `true`.
    public init(_ type: LoadingType, loopMode: LottieLoopMode = .loop, play: Binding<Bool> = .constant(true)) {
        self.type = type
        self.loopMode = loopMode
        _play = play
    }

    // MARK: - Public Methods
    
    /// Creates and configures the underlying UIKit view for the Lottie animation.
    public func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        
        switch type {
            case .url(let url):
                LottieAnimation.loadedFrom(url: url, closure: { animation in
                    animationView.animation = animation
                    animationView.play()
                }, animationCache: nil)
            case .name(let name):
                animationView.animation = LottieAnimation.named(name, bundle: .module)
            case .filePath(let filePath):
                animationView.animation = LottieAnimation.filepath(filePath)
            case .animation(let animation):
                animationView.animation = animation
        }

        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.play()

        animationView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor),
            animationView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor),
            animationView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor),
            animationView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        return view
    }

    /// Updates the view represented by this object.
    public func updateUIView(_ uiView: UIViewType, context: Context) {
        // No specific update needed in this case.
    }
}

extension LottieView {
    /// Plays the Lottie animation with an optional completion block.
    /// - Parameter completion: An optional completion block to be called when the animation completes.
    public func playAnimation(completion: LottieCompletionBlock?) {
        animationView.play(completion: completion)
    }

    /// Stops the Lottie animation.
    public func stopAnimation() {
        animationView.stop()
    }
}

