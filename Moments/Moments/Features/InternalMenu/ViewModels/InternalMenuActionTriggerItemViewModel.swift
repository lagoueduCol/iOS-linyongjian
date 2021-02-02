//
//  InternalMenuActionTriggerItemViewModel.swift
//  Moments
//
//  Created by Jake Lin on 19/10/20.
//

import UIKit
import DesignKit

class InternalMenuActionTriggerItemViewModel: InternalMenuItemViewModel {
    let type: InternalMenuItemType  = .actionTrigger

    var title: String { fatalError(L10n.Development.fatalErrorSubclassToImplement) }

    // swiftlint:disable unavailable_function
    func select() { fatalError(L10n.Development.fatalErrorSubclassToImplement) }
}
