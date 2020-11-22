//
//  SwiftUIMomentsListView.swift
//  Moments
//
//  Created by Jake Lin on 19/11/20.
//

import Combine
import SwiftUI

struct SwiftUIMomentsListView: View {
    @ObservedObject var momentsList: MomentsListObservableObject = MomentsListObservableObject(userID: UserDataStore.current.userID, momentsRepo: MomentsRepo.shared)

    @State private var isDragging: Bool = false

    var body: some View {
        ScrollView(axes, showsIndicators: true) {
            LazyVStack {
                ForEach (momentsList.listItems) { item in
                    SwiftUIMomentsListItemView(viewModel: item.viewModel, isDragging: $isDragging).ignoresSafeArea(.all)
                }.onAppear(perform: {
                    momentsList.loadItems()
                })
            }
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        //swiftlint:disable no_hardcoded_strings
        .background(Color("background"))
        //swiftlint:enable no_hardcoded_strings
        .ignoresSafeArea(.all)
    }
}

private extension SwiftUIMomentsListView {
    var axes: Axis.Set {
        return isDragging ? [] : .vertical
    }
}

struct SwiftUIMomentsListView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIMomentsListView()
    }
}
