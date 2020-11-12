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

struct RemoteTogglesDataStore: TogglesDataStoreType {
    static let shared: RemoteTogglesDataStore = .init()

    private let remoteConfigRepo: RemoteConfigRepoType

    private init(remoteConfigRepo: RemoteConfigRepoType = RemoteConfigRepo.shared) {
        self.remoteConfigRepo = remoteConfigRepo
    }

    func isToggleOn(_ toggle: ToggleType) -> Bool {
        guard let toggle = toggle as? RemoteToggle else {
            return false
        }

        guard let remoteConfiKey = FirebaseRemoteConfigKey(rawValue: toggle.rawValue) else {
            return false
        }
        return remoteConfigRepo.getBool(by: remoteConfiKey)
    }

    func update(toggle: ToggleType, value: Bool) { }
}
