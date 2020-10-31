//
//  InternalMenuFeatureToggleItemViewModel.swift
//  Moments
//
//  Created by Jake Lin on 31/10/20.
//

import Foundation

class InternalMenuFeatureToggleItemViewModel: InternalMenuItemViewModel {
    var type: InternalMenuItemType {
        .featureToggle
    }

    var title: String { "" }
    var on: Bool { false }

    func toggleOn() { }
    func toggleOff() { }
    func select() { }
}

// swiftlint:disable type_name
final class InternalMenuLikeButtonToggleItemViewModel: InternalMenuFeatureToggleItemViewModel {
    private let toggleStore: TogglesDataStoreType
    private var isOn: Bool

    override var title: String {
        return L10n.InternalMenu.likeButtonForMomentEnabled
    }

    override var on: Bool {
       return isOn
    }

    init(toggleStore: TogglesDataStoreType) {
        self.toggleStore = toggleStore
        self.isOn = toggleStore.isToggleOn(.isLikeButtonForMomentEnabled)
    }

    override func toggleOn() {
        toggleStore.update(toggle: .isLikeButtonForMomentEnabled, value: true)
    }

    override func toggleOff() {
        toggleStore.update(toggle: .isLikeButtonForMomentEnabled, value: false)
    }
}
