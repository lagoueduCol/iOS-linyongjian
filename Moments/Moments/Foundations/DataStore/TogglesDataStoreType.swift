//
//  TogglesDataStoreType.swift
//  Moments
//
//  Created by Jake Lin on 11/11/20.
//

import Foundation

protocol ToggleType { }

protocol TogglesDataStoreType {
    func isToggleOn(_ toggle: ToggleType) -> Bool
    func update(toggle: ToggleType, value: Bool)
}
