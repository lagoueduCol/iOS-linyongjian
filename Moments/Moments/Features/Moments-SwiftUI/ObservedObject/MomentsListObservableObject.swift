//
//  MomentsListObservableObject.swift
//  Moments
//
//  Created by Jake Lin on 19/11/20.
//

import Foundation
import Combine
import RxSwift

struct IdentifiableListItemViewModel: Identifiable {
    let id = UUID()
    var viewModel: ListItemViewModel
}

final class MomentsListObservableObject: ObservableObject {
    private let viewModel: MomentsListViewModel
    private let disposeBag: DisposeBag = .init()

    @Published var listItems: [IdentifiableListItemViewModel] = []

    init(userID: String,
         momentsRepo: MomentsRepoType) {
        viewModel = MomentsListViewModel(userID: userID, momentsRepo: momentsRepo)

        setupBindings()
    }

    func loadItems() {
        viewModel.loadItems()
            .subscribe()
            .disposed(by: disposeBag)
    }
}

private extension MomentsListObservableObject {
    func setupBindings() {
        viewModel.listItems
            .do(onNext: { [weak self] items in
                guard let self = self else { return }
                self.listItems.removeAll()
                self.listItems.append(contentsOf: items.flatMap { $0.items }.map { IdentifiableListItemViewModel(viewModel: $0) })
            })
            .subscribe()
            .disposed(by: disposeBag)
    }
}
