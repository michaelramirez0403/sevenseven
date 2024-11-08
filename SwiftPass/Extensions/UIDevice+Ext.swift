//
//  UIDeviceExtension.swift
//  Copyright © 2020 Macky Ramirez. All rights reserved.
//
import UIKit
public extension UIDevice {
    var iPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
    
    enum Screentype: String {
        case iPodTouch
        case iPhone4
        case iPhone5
        case iPhone5S, iPhone5C
        case iPhone6, iPhone6Plus
        case iPhone6S, iPhone6SPlus
        case iPhone7, iPhone7Plus
        case iPhone8, iPhone8Plus
        case iPhoneX, iPhoneXS, iPhoneXSMax
        case iPhoneXR
        case iPhone11, iPhone11Pro, iPhone11ProMax
        case iPhoneSE, iPhoneSE2, iPhoneSE3
        case iPhone12, iPhone12Pro, iPhone12ProMax, iPhone12Mini
        case iPhone13, iPhone13Pro, iPhone13ProMax, iPhone13Mini
        case unrecognized
    }
    
    var screenType: Screentype {
        guard iPhone else {
            return .unrecognized
        }
        switch UIScreen.main.nativeBounds.height {
        case 960:
            return .iPhone4
        case 1136:
            return .iPhone5  // .iPhones_5_5s_5c_SE iPodTouch
        case 1334:
            return .iPhone6  // .iPhones_6_6s_7_8
        case 1792:
            return .iPhone11
        case 1920, 2208:
            return .iPhone6Plus //  .iPhones_6Plus_6sPlus_7Plus_8Plus
        case 2340:
            return .iPhone13Mini
        case 2426:
            return .iPhone11Pro  // .iPhone_11Pro
        case 2436:
            return .iPhoneX
        case 2688:
            return .iPhoneXSMax  // .iPhone_XSMax_ProMax
        case 2532:
            return .iPhone12Pro  // .iPhone_12_12Pro_13_13Pro
        case 2778:
            return .iPhone12ProMax // .iPhone_12ProMax_13ProMax
        default:
            return .unrecognized
        }
    }
}
