//
//  ListItemCell.swift
//  Moments
//
//  Created by Jake Lin on 26/10/20.
//

import Foundation
import UIKit

protocol ListItemCell {
    associatedtype ViewModel
    func update(with viewModel: ViewModel)
}
