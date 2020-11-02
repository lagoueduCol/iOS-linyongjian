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
    override init() {
        super.init()

        self.viewModel = MomentsListViewModel(userID: UserDataStore.current.userID, momentsRepo: MomentsRepo.shared)
    }
}
