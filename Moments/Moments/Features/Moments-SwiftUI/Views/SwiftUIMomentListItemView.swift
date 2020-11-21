//
//  SwiftUIMomentListItemView.swift
//  Moments
//
//  Created by Jake Lin on 19/11/20.
//

import SwiftUI

struct SwiftUIMomentListItemView: View {
    let viewModel: MomentListItemViewModel

    var body: some View {
        Text(viewModel.userName)
            .frame(height: 120)
    }
}

//struct SwiftUIMomentListItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUIMomentListItemView()
//    }
//}
