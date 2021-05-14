//
//  ListItemView.swift
//  Moments
//
//  Created by Jake Lin on 27/10/20.
//

protocol ListItemView: AnyObject {
    func update(with viewModel: ListItemViewModel)
}
