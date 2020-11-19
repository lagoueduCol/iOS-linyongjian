//
//  SwiftUIUserProfileListItemView.swift
//  Moments
//
//  Created by Jake Lin on 19/11/20.
//

import SwiftUI

struct SwiftUIUserProfileListItemView: View {
    let viewModel: UserProfileListItemViewModel

    var body: some View {
        Text(viewModel.name)
    }
}

//struct SwiftUIUserProfileListItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUIUserProfileListItemView()
//    }
//}
