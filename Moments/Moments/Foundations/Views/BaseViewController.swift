//
//  BaseViewController.swift
//  Moments
//
//  Created by Jake Lin on 17/10/20.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    lazy var disposeBag: DisposeBag = .init()

    init() {
      super.init(nibName: nil, bundle: nil)
    }

    // swiftlint:disable no_hardcoded_strings
    @available(*, unavailable, message: "We don't support init view controller from a nib.")
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    // swiftlint:disable no_hardcoded_strings
    @available(*, unavailable, message: "We don't support init view controller from a nib.")
    required init?(coder aDecoder: NSCoder) {
        fatalError(L10n.Development.fatalErrorInitCoderNotImplemented)
    }
}
