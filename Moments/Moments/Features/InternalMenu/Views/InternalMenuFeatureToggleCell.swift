//
//  InternalMenuFeatureToggleCell.swift
//  Moments
//
//  Created by Jake Lin on 31/10/20.
//

import Foundation
import UIKit
import RxSwift

class InternalMenuFeatureToggleCell: InternalMenuCell<InternalMenuFeatureToggleItemViewModel> {
    private let switchControl: UISwitch = configure(.init()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private var item: InternalMenuFeatureToggleItemViewModel?
    private lazy var disposeBag: DisposeBag = .init()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
        setupBindings()
    }

    // swiftlint:disable unavailable_function
    required init?(coder: NSCoder) {
        fatalError(L10n.Development.fatalErrorInitCoderNotImplemented)
    }

    override func update(_ item: InternalMenuFeatureToggleItemViewModel) {
        self.item = item
        textLabel?.text = item.title
        switchControl.isOn = item.on
    }
}

private extension InternalMenuFeatureToggleCell {
    func setupUI() {
        selectionStyle = .none
        accessoryView = switchControl
    }

    func setupBindings() {
        switchControl.rx.isOn.changed
            .distinctUntilChanged()
            .asObservable()
            .subscribe(onNext: { [weak self] in
                self?.item?.toggle(isOn: $0)
            })
            .disposed(by: disposeBag)
    }
}
