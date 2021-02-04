//
//  InteralMenuCrashAppItemViewModel.swift
//  Moments
//
//  Created by Jake Lin on 10/11/20.
//

import Foundation

final class InternalMenuCrashAppItemViewModel: InternalMenuActionTriggerItemViewModel {
    override var title: String {
        return L10n.InternalMenu.crashApp
    }

    // swiftlint:disable unavailable_function
    override func select() {
        // swiftlint:disable fatal_error_message
        fatalError()
    }
}
