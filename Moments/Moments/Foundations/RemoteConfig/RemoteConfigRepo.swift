//
//  RemoteConfigRepo.swift
//  Moments
//
//  Created by Jake Lin on 11/11/20.
//

import Foundation

protocol RemoteConfigRepoType {
    func register(remoteConfigProvider: RemoteConfigProvider)

    func getString(by key: RemoteConfigKey) -> String?
    func getInt(by key: RemoteConfigKey) -> Int?
    func getBool(by key: RemoteConfigKey) -> Bool
}

final class RemoteConfigRepo: RemoteConfigRepoType {
    static let shared: RemoteConfigRepo = .init()

    private var remoteConfigProvider: RemoteConfigProvider!

    private init() { }

    func register(remoteConfigProvider: RemoteConfigProvider) {
        self.remoteConfigProvider = remoteConfigProvider
        self.remoteConfigProvider.setup()
        self.remoteConfigProvider.fetch()
    }

    func getString(by key: RemoteConfigKey) -> String? {
        return remoteConfigProvider.getString(by: key)
    }

    func getInt(by key: RemoteConfigKey) -> Int? {
        return remoteConfigProvider.getInt(by: key)
    }

    func getBool(by key: RemoteConfigKey) -> Bool {
        return remoteConfigProvider.getBool(by: key)
    }
}
