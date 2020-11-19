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

    var body: some View {
        List (momentsList.listItems) { item in
            SwiftUIMomentsListItemView(viewModel: item.viewModel)
        }.onAppear(perform: {
            momentsList.loadItems()
        })
    }
}

struct SwiftUIMomentsListView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIMomentsListView()
    }
}
