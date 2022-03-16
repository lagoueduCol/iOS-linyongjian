//
//  InternalTogglesDataSource.swift
//  Moments
//
//  Created by Jake Lin on 31/10/20.
//

import Foundation

enum InternalToggle: String, ToggleType {
    case isLikeButtonForMomentEnabled
    case isSwiftUIEnabled
}

struct InternalTogglesDataStore: TogglesDataStoreType {
    private let userDefaults: UserDefaults

    private init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
        self.userDefaults.register(defaults: [
            InternalToggle.isLikeButtonForMomentEnabled.rawValue: false,
            InternalToggle.isSwiftUIEnabled.rawValue: false
            ])
    }

    static let shared: InternalTogglesDataStore = .init(userDefaults: .standard)

    func isToggleOn(_ toggle: ToggleType) -> Bool {
        guard let toggle = toggle as? InternalToggle else {
            return false
        }

        return userDefaults.bool(forKey: toggle.rawValue)
    }

    func update(toggle: ToggleType, value: Bool) {
        guard let toggle = toggle as? InternalToggle else {
            return
        }

        userDefaults.set(value, forKey: toggle.rawValue)
    }
}
