//
//  UnitTestViewController.swift
//  MomentsTests
//
//  Created by Jake Lin on 15/11/20.
//

import UIKit

final class UnitTestViewController: UIViewController {
    private let messageLabel: UILabel = configure(.init()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = L10n.Development.runningUnitTests
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setConstraints()
    }
}

private extension UnitTestViewController {
    func setupUI() {
        view.backgroundColor = .green
        view.addSubview(messageLabel)
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
