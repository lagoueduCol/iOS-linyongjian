//
//  InternalMenuItemViewModel.swift
//  Moments
//
//  Created by Jake Lin on 17/10/20.
//

import Foundation

enum InternalMenuItemType: String {
    case description
    case featureToggle
    case actionTrigger
}

protocol InternalMenuItemViewModel {
    var type: InternalMenuItemType { get }
    var title: String { get }

    func select()
}

extension InternalMenuItemViewModel {
    func select() { }
}
