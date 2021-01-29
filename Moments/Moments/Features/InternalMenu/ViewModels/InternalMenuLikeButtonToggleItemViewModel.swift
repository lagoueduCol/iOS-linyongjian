//
//  InternalMenuLikeButtonToggleItemViewModel.swift
//  Moments
//
//  Created by Jake Lin on 29/1/21.
//

import Foundation

// swiftlint:disable type_name
final class InternalMenuLikeButtonToggleItemViewModel: InternalMenuFeatureToggleItemViewModel {
    private let togglesDataStore: TogglesDataStoreType

    override var title: String {
        return L10n.InternalMenu.likeButtonForMomentEnabled
    }

    override var isOn: Bool {
       return togglesDataStore.isToggleOn(InternalToggle.isLikeButtonForMomentEnabled)
    }

    init(togglesDataStore: TogglesDataStoreType) {
        self.togglesDataStore = togglesDataStore
    }

    override func toggle(isOn: Bool) {
        togglesDataStore.update(toggle: InternalToggle.isLikeButtonForMomentEnabled, value: isOn)
    }
}
