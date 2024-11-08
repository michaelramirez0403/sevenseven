//
//  PickPickLiveImagePicker.swift
//
//
//  Created by Michael Ramirez on 10/21/24.
//
import UIKit
import PhotosUI
// MARK: - PickPickLiveImagePickerDelegate Protocol
protocol PickPickLiveImagePickerDelegate: AnyObject {
    func liveImagePicker(_ imagePicker: PickaPicLiveImagePicker,
                         didSelect liveImage: PHLivePhoto)
    func imagePicker(_ imagePicker: PickaPicLiveImagePicker,
                     didSelect image: UIImage)
}
// MARK: - PickPickLiveImagePicker Class
class PickaPicLiveImagePicker: NSObject {
    // MARK: - Properties
    private weak var controller: PHPickerViewController?
    // MARK: - Public Methods
    weak var delegate: PickPickLiveImagePickerDelegate?
    // Dismiss the image picker
    func dismiss() {
        controller?.dismiss(animated: true,
                            completion: nil)
    }
    // Present the image picker with source type and editing option
    func present(from viewController: UIViewController) {
        DispatchQueue.main.async {
            var configuration = PHPickerConfiguration()
            configuration.selectionLimit = 10
            configuration.filter = .any(of: [.images, .livePhotos])
            configuration.preferredAssetRepresentationMode = .automatic
            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = self
            self.controller = picker
            viewController.present(picker, animated: true, completion: nil)
        }
    }
    fileprivate func parseLivePhoto(using itemProvider: NSItemProvider) {
        if itemProvider.canLoadObject(ofClass: PHLivePhoto.self) {
            itemProvider.loadObject(ofClass: PHLivePhoto.self) { [unowned self] livePhoto, _ in
                if let livePhoto = livePhoto as? PHLivePhoto {
                    self.delegate?.liveImagePicker(self, didSelect: livePhoto)
                }
            }
        }
    }
    fileprivate func parsePhoto(using itemProvider: NSItemProvider) {
        if itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [unowned self] image, _ in
                if let image = image as? UIImage {
                    self.delegate?.imagePicker(self, didSelect: image)
                }
            }
        }
    }
}
// MARK: - PHPickerViewControllerDelegate
extension PickaPicLiveImagePicker: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController,
                didFinishPicking results: [PHPickerResult]) {
        dismiss()
        guard !results.isEmpty else { return }
        for result in results {
            let itemProvider = result.itemProvider
            if itemProvider.canLoadObject(ofClass: PHLivePhoto.self) {
                // it's a live photo
                parseLivePhoto(using: itemProvider)
            } else if itemProvider.canLoadObject(ofClass: UIImage.self) {
                // it's a photo
                parsePhoto(using: itemProvider)
            }
        }
    }
}
