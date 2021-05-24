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
    let viewModel: ListItemViewModel
}

final class MomentsListObservableObject: ObservableObject {
    private let viewModel: MomentsTimelineViewModel
    private let disposeBag: DisposeBag = .init()

    @Published var listItems: [IdentifiableListItemViewModel] = []

    init(userID: String,
         momentsRepo: MomentsRepoType) {
        viewModel = MomentsTimelineViewModel(userID: userID, momentsRepo: momentsRepo)

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
            .observeOn(MainScheduler.instance)
            .do(onNext: { [weak self] items in
                guard let self = self else { return }
                self.listItems.removeAll()
                self.listItems.append(contentsOf: items.flatMap { $0.items }.map { IdentifiableListItemViewModel(viewModel: $0) })
            })
            .subscribe()
            .disposed(by: disposeBag)
    }
}
