//
//  TextStyleDemoViewController.swift
//  Moments
//
//  Created by Jake Lin on 14/2/21.
//

import UIKit

final class TextStylesDemoViewController: BaseViewController {
    private let rootStackView: UIStackView = configure(.init()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.alignment = .leading
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = UIEdgeInsets(top: 32, left: 16, bottom: 32, right: 16)
        $0.spacing = 16
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        rootStackView.arrangedSubviews.first?.removeFromSuperview()
        rootStackView.addArrangedSubview(buildTextStyles())
    }
}

private extension TextStylesDemoViewController {
    func setupUI() {
        view.backgroundColor = .systemBackground

        let scrollView: UIScrollView = configure(.init()) {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }

        scrollView.addSubview(rootStackView)

        rootStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width)
        }
    }

    func buildTextStyles() -> UIView {
        // swiftlint:disable no_hardcoded_strings
        let styles: [(String, UIFont.TextStyle)] = [
            (".largeTitle", .largeTitle),
            (".title1", .title1),
            (".title2", .title2),
            (".title3", .title3),
            (".headline", .headline),
            (".subheadline", .subheadline),
            (".body", .body),
            (".callout", .callout),
            (".footnote", .footnote),
            (".caption1", .caption1),
            (".caption2", .caption2)
        ]
        // swiftlint:enable no_hardcoded_strings

        let title: UILabel = configure(.init()) {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.text = L10n.InternalMenu.textStyles
            $0.font = UIFont.designKit.title1
        }

        let stackView: UIStackView = configure(.init(arrangedSubviews: [title])) {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.axis = .vertical
            $0.spacing = 8
        }
        styles.forEach {
            let name = $0.0
            let style = $0.1
            let font = UIFont.preferredFont(forTextStyle: style)
            let label: UILabel = configure(.init()) {
                $0.translatesAutoresizingMaskIntoConstraints = false
                // swiftlint:disable no_hardcoded_strings
                $0.text = "\(name): \(font.fontName) @ \(font.pointSize) pt"
                // swiftlint:enable no_hardcoded_strings
                $0.numberOfLines = 0
                $0.font = font
            }

            stackView.addArrangedSubview(label)
        }

        return stackView
    }
}
