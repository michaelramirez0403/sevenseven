//
//  PickaPicImagePicker.swift
//  
//
//  Created by Michael Ramirez on 10/1/24.
//

import UIKit
import AVKit
// MARK: - ImagePickerDelegate Protocol
protocol PickaPicImagePickerDelegate: AnyObject {
    func imagePicker(_ imagePicker: PickaPicImagePicker,
                     didSelect image: UIImage)
    func cancelButtonDidClick(on imagePicker: PickaPicImagePicker, msg: String)
}
// MARK: - ImagePicker Class
class PickaPicImagePicker: NSObject {
    // MARK: - Properties
    private weak var controller: UIImagePickerController?
    weak var delegate: PickaPicImagePickerDelegate?
    // MARK: - Public Methods
    // Dismiss the image picker
    func dismiss() {
        controller?.dismiss(animated: true, completion: nil)
    }
    // Present the image picker with source type and editing option
    func present(from viewController: UIViewController,
                 sourceType: UIImagePickerController.SourceType,
                 allowsEditing: Bool = false) {
        
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else {
            return
        }
        DispatchQueue.main.async {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            imagePickerController.allowsEditing = allowsEditing
            self.controller = imagePickerController
            viewController.present(imagePickerController, animated: true, completion: nil)
        }
    }
    func selectfromCamera(from viewController: UIViewController) {
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
            if response {
                self.present(from: viewController, sourceType: .camera)
            } else {
                self.delegate?.cancelButtonDidClick(on: self,
                                                    msg: "Not able to open camera. Go to Generals and manually allow access app of camera.")
            }
        }
    }
    func selectFromLibrary(from viewController: UIViewController) {
        present(from: viewController, sourceType: .photoLibrary)
    }
    // Display an alert to choose between camera and photo library
    func showImagePicker(from viewController: UIViewController,
                         allowsEditing: Bool) {
        let optionMenu = UIAlertController(title: "Select an image source",
                                           message: nil,
                                           preferredStyle: .alert)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let takePhotoAction = UIAlertAction(title: "Take Photo",
                                                style: .default) { [unowned self] _ in
                self.present(from: viewController,
                             sourceType: .camera,
                             allowsEditing: allowsEditing)
            }
            optionMenu.addAction(takePhotoAction)
        }
        let selectFromLibraryAction = UIAlertAction(title: "Select from Library",
                                                    style: .default) { [unowned self] _ in
            self.present(from: viewController,
                         sourceType: .photoLibrary,
                         allowsEditing: allowsEditing)
        }
        optionMenu.addAction(selectFromLibraryAction)
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        optionMenu.addAction(cancelAction)
        
        viewController.present(optionMenu, animated: true, completion: nil)
    }
}

// MARK: - UIImagePickerControllerDelegate
extension PickaPicImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // Called when an image is selected or captured
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            delegate?.imagePicker(self, didSelect: editedImage)
        } else if let originalImage = info[.originalImage] as? UIImage {
            delegate?.imagePicker(self, didSelect: originalImage)
        } else {
            print("Image source not recognized")
        }
        DispatchQueue.main.async {
            self.dismiss()
        }
    }
    
    // Called when the user cancels the image picker
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        DispatchQueue.main.async {
            self.dismiss()
        }
        delegate?.cancelButtonDidClick(on: self, msg: "Camera or photo library was cancelled.")
    }
}
