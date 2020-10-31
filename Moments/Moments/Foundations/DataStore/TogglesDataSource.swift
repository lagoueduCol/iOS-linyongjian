//
//  TogglesDataSource.swift
//  Moments
//
//  Created by Jake Lin on 31/10/20.
//

import Foundation

protocol TogglesDataStoreType {
    func isToggleOn(_ toggle: Toggle) -> Bool
    func update(toggle: Toggle, value: Bool)
}

enum Toggle: String {
    case isLikeButtonForMomentEnabled
}

struct TogglesDataStore: TogglesDataStoreType {
    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
        self.userDefaults.register(defaults: [
            Toggle.isLikeButtonForMomentEnabled.rawValue: false
            ])
    }

    func isToggleOn(_ toggle: Toggle) -> Bool {
        return userDefaults.bool(forKey: toggle.rawValue)
    }

    func update(toggle: Toggle, value: Bool) {
        userDefaults.set(value, forKey: toggle.rawValue)
    }
}
