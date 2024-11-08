//
//  Defaults.swift
//
//
//  Created by Michael Ramirez on 10/21/24.
//
import UIKit
enum UserDefaultKeys: String, CaseIterable {
    case normalPhoto = "NormalPhoto"
    case livePhoto = "LivePhoto"
    case name = "Name"
    case username = "Username"
}
final class Defaults {
    static func saveData(data: Data, key: UserDefaultKeys) {
        let encoded = try! PropertyListEncoder().encode(data)
        let defaults = UserDefaults.standard
        defaults.set(encoded, forKey: key.rawValue)
        print("Saved \(key.rawValue).")
    }
    static func setData<T>(value: T, key: UserDefaultKeys) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key.rawValue)
    }
    static func getData<T>(type: T.Type, forKey: UserDefaultKeys) -> T? {
        let defaults = UserDefaults.standard
        let value = defaults.object(forKey: forKey.rawValue) as? T
        return value
    }
    static func removeData(key: UserDefaultKeys) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key.rawValue)
    }
}

