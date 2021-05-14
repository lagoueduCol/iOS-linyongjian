//
//  FirebaseABTestProvider.swift
//  Moments
//
//  Created by Jake Lin on 14/11/20.
//

import Foundation

struct FirebaseABTestProvider: ABTestProvider {
    static let shared: FirebaseABTestProvider = .init()

    private let remoteConfigProvider: RemoteConfigProvider

    private init(remoteConfigProvider: RemoteConfigProvider = FirebaseRemoteConfigProvider.shared) {
        self.remoteConfigProvider = remoteConfigProvider
    }

    var likeButtonStyle: LikeButtonStyle? {
        guard let likeButtonStyleString = remoteConfigProvider.getString(by: FirebaseRemoteConfigKey.likeButtonStyle) else {
            return nil
        }
        return LikeButtonStyle(rawValue: likeButtonStyleString)
    }
}
