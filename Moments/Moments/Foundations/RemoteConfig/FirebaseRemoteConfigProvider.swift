//
//  FirebaseRemoteConfigProvider.swift
//  Moments
//
//  Created by Jake Lin on 11/11/20.
//

import Foundation
import FirebaseRemoteConfig

enum FirebaseRemoteConfigKey: String, RemoteConfigKey {
    case isRoundedAvatar
}

struct FirebaseRemoteConfigProvider: RemoteConfigProvider {
    let remoteConfig = RemoteConfig.remoteConfig()

    func setup() {
        let defaultValues = [FirebaseRemoteConfigKey.isRoundedAvatar.rawValue: false as NSObject]
        remoteConfig.setDefaults(defaultValues)
    }

    func fetch() {
        remoteConfig.fetchAndActivate()
    }

    func getString(by key: RemoteConfigKey) -> String? {
        guard let key = key as? FirebaseRemoteConfigKey else {
            return nil
        }

        return remoteConfig.value(forKey: key.rawValue) as? String
    }

    func getInt(by key: RemoteConfigKey) -> Int? {
        guard let key = key as? FirebaseRemoteConfigKey else {
            return nil
        }

        return remoteConfig.value(forKey: key.rawValue) as? Int
    }

    func getBool(by key: RemoteConfigKey) -> Bool {
        guard let key = key as? FirebaseRemoteConfigKey else {
            return false
        }

        return remoteConfig.value(forKey: key.rawValue) as? Bool ?? false
    }
}
