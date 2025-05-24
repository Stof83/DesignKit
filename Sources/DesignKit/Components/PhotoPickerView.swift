//
//  PhotoPickerView.swift
//
//
//  Created by El Mostafa El Ouatri on 16/11/23.
//

import SwiftUI
import PhotosUI

/// A SwiftUI representation of a photo picker view using `PHPickerViewController`.
import SwiftUI

/// A SwiftUI representation of a photo picker view using `UIImagePickerController`.
public struct PhotoPickerView: UIViewControllerRepresentable {
    
    // MARK: - @Environment Properties
    @Environment(\.presentationMode) private var presentationMode
    
    // MARK: - @Binding Properties
    /// Binding for the selected image.
    @Binding public var image: UIImage?

    // MARK: - Public Properties
    /// The source type for the image picker.
    public var sourceType: UIImagePickerController.SourceType = .camera

    // MARK: - Life Cycle
    public init(image: Binding<UIImage?>, sourceType: UIImagePickerController.SourceType) {
        self._image = image
        self.sourceType = sourceType
    }
    
    /// Creates and returns a `UIImagePickerController` configured with the specified source type.
    public func makeUIViewController(context: Context) -> UIImagePickerController {

        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator

        return imagePicker
    }

    /// Updates the view controller (no implementation needed for this case).
    public func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {

    }

    /// Creates a coordinator to handle events from the `UIImagePickerController`.
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    /// A coordinator class to handle events from the `UIImagePickerController`.
    final public class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        /// The parent `PhotoPickerView`.
        var parent: PhotoPickerView

        /// Initializes the coordinator with a parent `PhotoPickerView`.
        init(_ parent: PhotoPickerView) {
            self.parent = parent
        }

        /// Called when the user picks a media item.
        public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.image = image
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}


