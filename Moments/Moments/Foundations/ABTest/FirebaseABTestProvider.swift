//
//  FirebaseABTestProvider.swift
//  Moments
//
//  Created by Jake Lin on 14/11/20.
//

import Foundation

struct FirebaseABTestProvider: ABTestProvider {
    static let shared: FirebaseABTestProvider = .init()

    private let remoteConfigRepo: RemoteConfigRepoType

    private init(remoteConfigRepo: RemoteConfigRepoType = RemoteConfigRepo.shared) {
        self.remoteConfigRepo = remoteConfigRepo
    }

    var likeButtonStyle: LikeButtonStyle? {
        guard let likeButtonStyleString = remoteConfigRepo.getString(by: FirebaseRemoteConfigKey.likeButtonStyle) else {
            return nil
        }
        return LikeButtonStyle(rawValue: likeButtonStyleString)
    }
}
