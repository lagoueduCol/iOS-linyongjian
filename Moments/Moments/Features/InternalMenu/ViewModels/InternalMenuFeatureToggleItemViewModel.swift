//
//  InternalMenuFeatureToggleItemViewModel.swift
//  Moments
//
//  Created by Jake Lin on 31/10/20.
//

import Foundation

struct InternalMenuFeatureToggleItemViewModel: InternalMenuItemViewModel {
    private let toggle: ToggleType
    private let togglesDataStore: TogglesDataStoreType

    init(title: String, toggle: ToggleType, togglesDataStore: TogglesDataStoreType = InternalTogglesDataStore.shared) {
        self.title = title
        self.toggle = toggle
        self.togglesDataStore = togglesDataStore
    }

    var type: InternalMenuItemType { .featureToggle }
    let title: String

    var isOn: Bool {
       return togglesDataStore.isToggleOn(toggle)
    }

    func toggle(isOn: Bool) {
        togglesDataStore.update(toggle: toggle, value: isOn)
    }
}
