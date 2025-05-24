//
//  UIImageView.swift
//
//
//  Created by El Mostafa El Ouatri on 29/08/23.
//

import Kingfisher
import UIKit

extension UIImageView {
    public func load(url: URL?, size: CGSize? = nil) {
        guard let url else { return }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        if let size {
                            self?.image = image.resize(to: size)
                        } else {
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
    
    public func load(from urlString: String?, size: CGSize? = nil, completion: ((Bool) -> Void)? = nil) {
        guard let urlString else { return }
        
        self.loadImage(from: urlString) { result in
            switch result {
                case .success(let value):
                    if let image = value.image {
                        if let size {
                            self.image = image.resize(to: size)
                        } else {
                            self.image = image
                        }
                        completion?(true)
                    } else {
                        self.loadImageResource(urlString: urlString, size: size, completion: completion)
                    }
                case .failure(_):
                    self.loadImageResource(urlString: urlString, size: size, completion: completion)
            }
        }
    }
    
    func loadImage(from url: String, size: CGSize? = nil, completion: ((Result<ImageCacheResult, KingfisherError>) -> Void)?) {
        var options: KingfisherOptionsInfo?
        
        if let size {
            let processor = ResizingImageProcessor(
                referenceSize: size
            )
            options = [ .processor(processor), .scaleFactor(UIScreen.main.scale)]
        }
        
        return ImageCache.default.retrieveImage(forKey: url, options: options, completionHandler: completion)
    }

    func loadImageResource(urlString: String, size: CGSize? = nil, completion: ((Bool) -> Void)? = nil) {
        guard let url = URL(string: urlString) else {
            completion?(false)
            return
        }
        
        let resource = KF.ImageResource(downloadURL: url, cacheKey: urlString)
        var options: KingfisherOptionsInfo?
        
        if let size {
            // let processor = DownsamplingImageProcessor(size: size)
            let scale = UIScreen.main.scale
            let processor = ResizingImageProcessor(
                referenceSize: size
            )
            
            options = [
                .processor(processor),
                .loadDiskFileSynchronously,
                .cacheOriginalImage,
                .transition(.fade(0.25))
            ]
        }

        self.kf.setImage(with: resource, options: options)
        
        completion?(true)
    }
    
}

extension UIImage {
    public func resize(to newSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: newSize)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
