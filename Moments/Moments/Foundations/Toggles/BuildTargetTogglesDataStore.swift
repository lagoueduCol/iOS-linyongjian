//
//  BuildTargetTogglesDataStore.swift
//  Moments
//
//  Created by Jake Lin on 11/11/20.
//

import Foundation

enum BuildTargetToggle: ToggleType {
    case debug, `internal`, production
}

struct BuildTargetTogglesDataStore: TogglesDataStoreType {
    static let shared: BuildTargetTogglesDataStore = .init()

    private let buildTarget: BuildTargetToggle

    private init() {
        #if DEBUG
        buildTarget = .debug
        #endif

        #if INTERNAL
        buildTarget = .internal
        #endif

        #if PRODUCTION
        buildTarget = .production
        #endif
    }

    func isToggleOn(_ toggle: ToggleType) -> Bool {
        guard let toggle = toggle as? BuildTargetToggle else {
            return false
        }

        return toggle == buildTarget
    }

    func update(toggle: ToggleType, value: Bool) { }
}
