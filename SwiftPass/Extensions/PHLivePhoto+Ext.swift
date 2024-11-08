//
//  PHLivePhoto+Ext.swift
//  
//
//  Created by Michael Ramirez on 10/1/24.
//

import UIKit
import PhotosUI
extension PHLivePhoto {
//    func convertLivePhotoToNSData() -> Data {
//        return NSKeyedArchiver.archivedData(withRootObject: self) as Data
//    }
//    class func livePhotoFromNSData(data: NSData) -> PHLivePhoto? {
//        return NSKeyedUnarchiver.unarchiveObject(with: data as Data) as? PHLivePhoto
//    }
    func convertLivePhotoToData() -> Data? {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: true)
            return data
        } catch {
            print("Failed to archive Live Photo: \(error)")
            return nil
        }
    }

    class func livePhoto(from data: Data) -> PHLivePhoto? {
        do {
            let unarchivedObject = try NSKeyedUnarchiver.unarchivedObject(ofClass: PHLivePhoto.self, from: data)
            return unarchivedObject
        } catch {
            print("Failed to unarchive Live Photo: \(error)")
            return nil
        }
    }
}
extension PHLivePhotoView {
    func configureCircular() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderWidth = 2.0
        layer.masksToBounds = false
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
        contentMode = .scaleAspectFill
    }
    func configureRegular() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        clipsToBounds = true
        contentMode = .scaleAspectFill
    }
}
