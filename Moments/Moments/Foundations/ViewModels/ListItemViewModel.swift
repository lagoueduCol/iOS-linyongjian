//
//  ListItemViewModel.swift
//  Moments
//
//  Created by Jake Lin on 26/10/20.
//

import Foundation

protocol ListItemViewModel {
    static var reuseIdentifier: String { get }
}

extension ListItemViewModel {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
