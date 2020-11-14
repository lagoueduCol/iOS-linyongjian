//
//  FirebaseRemoteConfigProvider.swift
//  Moments
//
//  Created by Jake Lin on 11/11/20.
//

import Foundation
import FirebaseRemoteConfig

enum FirebaseRemoteConfigKey: String, CaseIterable, RemoteConfigKey {
    case isRoundedAvatar
    case likeButtonStyle
}

struct FirebaseRemoteConfigProvider: RemoteConfigProvider {
    let remoteConfig = RemoteConfig.remoteConfig()

    func setup() {
        // swiftlint:disable no_hardcoded_strings
        remoteConfig.setDefaults(fromPlist: "FirebaseRemoteConfigDefaults")
    }

    func fetch() {
        remoteConfig.fetchAndActivate()
    }

    func getString(by key: RemoteConfigKey) -> String? {
        guard let key = key as? FirebaseRemoteConfigKey else {
            return nil
        }

        return remoteConfig[key.rawValue].stringValue
    }

    func getInt(by key: RemoteConfigKey) -> Int? {
        guard let key = key as? FirebaseRemoteConfigKey else {
            return nil
        }

        return Int(truncating: remoteConfig[key.rawValue].numberValue)
    }

    func getBool(by key: RemoteConfigKey) -> Bool {
        guard let key = key as? FirebaseRemoteConfigKey else {
            return false
        }

        return remoteConfig[key.rawValue].boolValue
    }
}
