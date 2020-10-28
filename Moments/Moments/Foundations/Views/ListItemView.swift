//
//  ListItemView.swift
//  Moments
//
//  Created by Jake Lin on 27/10/20.
//

import Foundation
import UIKit

protocol ListItemView: class {
    func update(with viewModel: ListItemViewModel)
}
