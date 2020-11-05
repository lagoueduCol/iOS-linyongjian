//
//  MomentsListViewController.swift
//  Moments
//
//  Created by Jake Lin on 28/10/20.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import DesignKit

final class MomentsListViewController: BaseTableViewController {
    let trackingRepo: TrackingRepoType

    init(trackingRepo: TrackingRepoType = TrackingRepo.shared) {
        self.trackingRepo = trackingRepo
        super.init()
        viewModel = MomentsListViewModel(userID: UserDataStore.current.userID, momentsRepo: MomentsRepo.shared)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // The screen name should match the same screen on Android
        trackingRepo.trackScreenviews(ScreenviewsTrackingEvent(screenName: L10n.Tracking.momentsScreen, screenClass: String(describing: self)))
    }
}
