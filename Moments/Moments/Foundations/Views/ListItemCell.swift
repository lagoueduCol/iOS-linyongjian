//
//  ListItemCell.swift
//  Moments
//
//  Created by Jake Lin on 26/10/20.
//

protocol ListItemCell: AnyObject {
    func update(with viewModel: ListItemViewModel)
}
