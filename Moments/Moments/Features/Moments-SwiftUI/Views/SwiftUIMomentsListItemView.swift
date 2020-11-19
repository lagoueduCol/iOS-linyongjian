//
//  SwiftUIMomentsListItemView.swift
//  Moments
//
//  Created by Jake Lin on 20/11/20.
//

import SwiftUI

struct SwiftUIMomentsListItemView: View {
    let viewModel: ListItemViewModel

    var body: some View {
        if let viewModel = viewModel as? UserProfileListItemViewModel {
            SwiftUIUserProfileListItemView(viewModel: viewModel)
        } else if let viewModel = viewModel as? MomentListItemViewModel {
            SwiftUIMomentListItemView(viewModel: viewModel)
        }
    }
}
