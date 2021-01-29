//
//  InternalMenuFeatureToggleItemViewModel.swift
//  Moments
//
//  Created by Jake Lin on 31/10/20.
//

import Foundation

class InternalMenuFeatureToggleItemViewModel: InternalMenuItemViewModel {
    var type: InternalMenuItemType { .featureToggle }

    var title: String { fatalError(L10n.Development.fatalErrorSubclassToImplement) }
    var isOn: Bool { false }

    // swiftlint:disable unavailable_function
    func toggle(isOn: Bool) { fatalError(L10n.Development.fatalErrorSubclassToImplement) }
    func select() { }
}
