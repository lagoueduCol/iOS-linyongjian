//
//  RemoteTogglesDataStore.swift
//  Moments
//
//  Created by Jake Lin on 11/11/20.
//

import Foundation

enum RemoteToggle: String, ToggleType {
    case isRoundedAvatar
}

struct FirebaseRemoteTogglesDataStore: TogglesDataStoreType {
    static let shared: FirebaseRemoteTogglesDataStore = .init()

    private let remoteConfigProvider: RemoteConfigProvider

    private init(remoteConfigProvider: RemoteConfigProvider = FirebaseRemoteConfigProvider.shared) {
        self.remoteConfigProvider = remoteConfigProvider
        self.remoteConfigProvider.setup()
        self.remoteConfigProvider.fetch()
    }

    func isToggleOn(_ toggle: ToggleType) -> Bool {
        guard let toggle = toggle as? RemoteToggle, let remoteConfiKey = FirebaseRemoteConfigKey(rawValue: toggle.rawValue) else {
            return false
        }

        return remoteConfigProvider.getBool(by: remoteConfiKey)
    }

    func update(toggle: ToggleType, value: Bool) { }
}
