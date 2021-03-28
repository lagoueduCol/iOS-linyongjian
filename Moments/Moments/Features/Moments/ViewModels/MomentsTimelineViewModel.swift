//
//  MomentsTimelineViewModel.swift
//  Moments
//
//  Created by Jake Lin on 26/10/20.
//

import Foundation
import RxSwift
import RxDataSources

struct MomentsTimelineViewModel: ListViewModel {
    private(set) var listItems: BehaviorSubject<[SectionModel<String, ListItemViewModel>]> = .init(value: [])
    private(set) var hasError: BehaviorSubject<Bool> = .init(value: false)

    private let disposeBag: DisposeBag = .init()
    private let userID: String
    private let momentsRepo: MomentsRepoType
    private let trackingRepo: TrackingRepoType

    init(userID: String,
         momentsRepo: MomentsRepoType = MomentsRepo.shared,
         trackingRepo: TrackingRepoType = TrackingRepo.shared) {
        self.userID = userID
        self.momentsRepo = momentsRepo
        self.trackingRepo = trackingRepo

        setupBindings()
    }

    func loadItems() -> Observable<Void> {
        return momentsRepo.getMoments(userID: userID)
    }

    func trackScreenviews() {
        // The screen name should match the same screen on Android
        trackingRepo.trackScreenviews(ScreenviewsTrackingEvent(screenName: L10n.Tracking.momentsScreen, screenClass: String(describing: self)))
    }
}

private extension MomentsTimelineViewModel {
    func setupBindings() {
        momentsRepo.momentsDetails
            .map {
                [UserProfileListItemViewModel(userDetails: $0.userDetails)]
                    + $0.moments.map { MomentListItemViewModel(moment: $0) }
            }
            .subscribe(onNext: {
                listItems.onNext([SectionModel(model: "", items: $0)])
            }, onError: { _ in
                hasError.onNext(true)
            })
            .disposed(by: disposeBag)
    }
}
