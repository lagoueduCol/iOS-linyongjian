//
//  InternalMenuDescriptionItemViewModel.swift
//  Moments
//
//  Created by Jake Lin on 17/10/20.
//

struct InternalMenuDescriptionItemViewModel: InternalMenuItemViewModel {
    let title: String

    var type: InternalMenuItemType { .description }
}
