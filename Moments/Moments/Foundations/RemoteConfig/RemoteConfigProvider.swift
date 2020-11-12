//
//  RemoteConfigProvider.swift
//  Moments
//
//  Created by Jake Lin on 11/11/20.
//

import Foundation

protocol RemoteConfigKey { }

protocol RemoteConfigProvider {
    func setup()
    func fetch()

    func getString(by key: RemoteConfigKey) -> String?
    func getInt(by key: RemoteConfigKey) -> Int?
    func getBool(by key: RemoteConfigKey) -> Bool
}
