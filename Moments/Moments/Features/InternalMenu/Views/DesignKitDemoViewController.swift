//
//  DesignKitDemoViewController.swift
//  Moments
//
//  Created by Jake Lin on 20/10/20.
//

import UIKit

final class DesignKitDemoViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
}

private extension DesignKitDemoViewController {
    func setupViews() {
        view.backgroundColor = .systemBackground

        let scrollView = configure(UIScrollView()) {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        self.view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)])

        let rootStackView = configure(UIStackView(arrangedSubviews: [
            buildTypography()
        ])) {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.axis = .vertical
            $0.alignment = .leading
            $0.isLayoutMarginsRelativeArrangement = true
            $0.layoutMargins = UIEdgeInsets(top: 32, left: 16, bottom: 32, right: 16)
            $0.spacing = 16
        }
        scrollView.addSubview(rootStackView)

        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            rootStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            rootStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1),
            rootStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)])
    }

    func buildTypography() -> UIView {
        let items = [("display1", UIFont.designKit.display1),
                 ("display2", UIFont.designKit.display2),
                 ("title1", UIFont.designKit.title1),
                 ("title2", UIFont.designKit.title2),
                 ("title3", UIFont.designKit.title3),
                 ("title4", UIFont.designKit.title4),
                 ("title5", UIFont.designKit.title5),
                 ("bodyBold", UIFont.designKit.bodyBold),
                 ("body", UIFont.designKit.body),
                 ("captionBold", UIFont.designKit.captionBold),
                 ("caption", UIFont.designKit.caption),
                 ("small", UIFont.designKit.small)]

        let title = UILabel()
        title.text = "# Typography"
        title.font = UIFont.designKit.title1

        let stack = configure(UIStackView(arrangedSubviews: [title])) {
            $0.axis = .vertical
            $0.spacing = 8
        }
        items.forEach {
            let item = $0
            let label = configure(UILabel()) {
                $0.text = item.0
                $0.setDynamicFont(item.1)
            }

            stack.addArrangedSubview(label)
        }

        return stack
    }
}
