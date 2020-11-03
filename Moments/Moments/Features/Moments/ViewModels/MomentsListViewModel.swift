//
//  MomentsListViewModel.swift
//  Moments
//
//  Created by Jake Lin on 26/10/20.
//

import Foundation
import RxSwift
import RxDataSources

struct MomentsListViewModel: ListViewModel {
    private(set) var listItems: BehaviorSubject<[SectionModel<String, ListItemViewModel>]> = .init(value: [])
    private(set) var hasError: BehaviorSubject<Bool> = .init(value: false)

    private let disposeBag: DisposeBag = .init()
    private let userID: String
    private let momentsRepo: MomentsRepoType

    init(userID: String,
         momentsRepo: MomentsRepoType) {
        self.userID = userID
        self.momentsRepo = momentsRepo

        setupBindings()
    }

    func executeQuery() -> Observable<Void> {
        return momentsRepo.getMoments(userID: userID)
    }
}

private extension MomentsListViewModel {
    func setupBindings() {
        momentsRepo.momentsDetails.asObservable()
            .observeOn(MainScheduler.instance)
            .debug()
            .subscribe(onNext: {
                transform(momentsDetails: $0)
            }, onError: { _ in
                hasError.onNext(true)
            })
            .disposed(by: disposeBag)
    }

    func transform(momentsDetails: MomentsDetails) {
        let items: [ListItemViewModel] = [
            UserProfileListItemViewModel(userDetails: momentsDetails.userDetails)
        ] + momentsDetails.moments.map { MomentListItemViewModel(moment: $0) }

        listItems.onNext([SectionModel(model: "", items: items)])
    }
}
