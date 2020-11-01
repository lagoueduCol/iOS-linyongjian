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

    private let userID: String
    private let momentsRepo: MomentsRepoType

    init(userID: String,
         momentsRepo: MomentsRepoType) {
        self.userID = userID
        self.momentsRepo = momentsRepo
    }

    func executeQuery() -> Observable<Void> {
        return momentsRepo
            .getMoments(userID: userID)
            .observeOn(MainScheduler.instance)
            .map { onQueryExecuteSuccess(momentsDetails: $0) }
            .catchError {
                onQueryExecuteFailure(error: $0)
                return Observable.just(())
            }
            .share()
    }
}

private extension MomentsListViewModel {
    func onQueryExecuteSuccess(momentsDetails: MomentsDetails) {
        let items: [ListItemViewModel] = [
            UserProfileListItemViewModel(userDetails: momentsDetails.userDetails)
        ] + momentsDetails.moments.map { MomentListItemViewModel(moment: $0) }

        listItems.onNext([SectionModel(model: "", items: items)])
    }

    func onQueryExecuteFailure(error: Error) {
        hasError.onNext(true)
        // If there is some custom error handling logic, put them here
    }
}
