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

    var title: String { fatalError(L10n.Development.fatalErrorSubclassToImplement) }
    var on: Bool { false }

    // swiftlint:disable unavailable_function
    func toggle(isOn: Bool) { fatalError(L10n.Development.fatalErrorSubclassToImplement) }
    func select() { }
}

// swiftlint:disable type_name
final class InternalMenuLikeButtonToggleItemViewModel: InternalMenuFeatureToggleItemViewModel {
    private let togglesDataStore: TogglesDataStoreType
    private var isOn: Bool

    override var title: String {
        return L10n.InternalMenu.likeButtonForMomentEnabled
    }

    override var on: Bool {
       return isOn
    }

    init(togglesDataStore: TogglesDataStoreType) {
        self.togglesDataStore = togglesDataStore
        isOn = togglesDataStore.isToggleOn(InternalToggle.isLikeButtonForMomentEnabled)
    }

    override func toggle(isOn: Bool) {
        togglesDataStore.update(toggle: InternalToggle.isLikeButtonForMomentEnabled, value: isOn)
    }
}
