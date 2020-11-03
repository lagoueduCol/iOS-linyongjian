//
//  MomentListItemView.swift
//  Moments
//
//  Created by Jake Lin on 29/10/20.
//

import Foundation
import UIKit
import DesignKit

final class MomentListItemView: BaseListItemView {
    private let userAvatarImageView: UIImageView = configure(.init()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.asAvatar(cornerRadius: 4)
        $0.contentMode = .scaleAspectFill
        $0.accessibilityIgnoresInvertColors = true
    }

    private let userNameLabel: UILabel = configure(.init()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.designKit.background
        $0.setDynamicFont(UIFont.designKit.captionBold)
        $0.textColor = UIColor.designKit.primaryText
        $0.numberOfLines = 1
    }

    private let titleLabel: UILabel = configure(.init()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.designKit.background
        $0.setDynamicFont(UIFont.designKit.body)
        $0.textColor = UIColor.designKit.secondaryText
        $0.numberOfLines = 1
    }

    private let momentImageView: UIImageView = configure(.init()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.accessibilityIgnoresInvertColors = true
        $0.clipsToBounds = true
    }

    private let postDateDescriptionLabel: UILabel = configure(.init()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.designKit.background
        $0.setDynamicFont(UIFont.designKit.small)
        $0.textColor = UIColor.designKit.tertiaryText
        $0.numberOfLines = 1
    }

    private let favoriteButton: UIButton = configure(.init()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.asHeartFavoriteButton()
    }

    private let dividerView: UIView = configure(.init()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.designKit.line
    }

    private let toggleDataStore: TogglesDataStoreType
    private let userDataStore: UserDataStoreType

    override convenience init(frame: CGRect = .zero) {
        self.init(frame: frame, toggleDataStore: TogglesDataStore.shared)
    }

    init(frame: CGRect = .zero, userDataStore: UserDataStoreType = UserDataStore.current, toggleDataStore: TogglesDataStoreType = TogglesDataStore.shared) {
        self.toggleDataStore = toggleDataStore
        self.userDataStore = userDataStore
        super.init(frame: frame)

        setupUI()
        setupConstraints()
    }

    // swiftlint:disable unavailable_function
    required init?(coder aDecoder: NSCoder) {
        fatalError(L10n.Development.fatalErrorInitCoderNotImplemented)
    }

    override func update(with viewModel: ListItemViewModel) {
        guard let viewModel = viewModel as? MomentListItemViewModel else {
            return
        }

        userAvatarImageView.kf.setImage(with: viewModel.userAvatarURL)
        userNameLabel.text = viewModel.userName
        titleLabel.text = viewModel.title
        momentImageView.kf.setImage(with: viewModel.photoURL)
        postDateDescriptionLabel.text = viewModel.postDateDescription

        if toggleDataStore.isToggleOn(.isLikeButtonForMomentEnabled) {
            favoriteButton.isSelected = viewModel.isLiked
            favoriteButton.rx.tap
                .bind(onNext: { [weak self] in
                    guard let self = self else { return }
                    if self.favoriteButton.isSelected {
                        viewModel.like(from: self.userDataStore.userID).subscribe(onNext: {}).disposed(by: self.disposeBag)
                    } else {
                        viewModel.unlike(from: self.userDataStore.userID).subscribe(onNext: {}).disposed(by: self.disposeBag)
                    }
                })
                .disposed(by: disposeBag)
        }
    }
}

private extension MomentListItemView {
    func setupUI() {
        backgroundColor = UIColor.designKit.background

        let verticalStackView: UIStackView = configure(.init(arrangedSubviews: [userNameLabel, titleLabel, momentImageView, postDateDescriptionLabel])) {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.axis = .vertical
            $0.alignment = .leading
            $0.spacing = Spacing.extraSmall
        }

        let horizontalStackView: UIStackView = configure(.init(arrangedSubviews:[userAvatarImageView, verticalStackView])) {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.alignment = .top
            $0.spacing = Spacing.small
        }

        [horizontalStackView, dividerView].forEach {
            addSubview($0)
        }

        horizontalStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Spacing.medium)
            $0.bottom.equalToSuperview().offset(-Spacing.medium)
            $0.leading.equalToSuperview().offset(Spacing.medium)
            $0.trailing.equalToSuperview().offset(-Spacing.medium)
        }

        // Add `favoriteButton` if the toggle is ON
        if toggleDataStore.isToggleOn(.isLikeButtonForMomentEnabled) {
            addSubview(favoriteButton)
        }
    }

    func setupConstraints() {
        userAvatarImageView.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.width.equalTo(40)
        }

        momentImageView.snp.makeConstraints {
            $0.height.equalTo(120)
            $0.width.equalTo(240)
        }

        if toggleDataStore.isToggleOn(.isLikeButtonForMomentEnabled) {
            favoriteButton.snp.makeConstraints {
                $0.bottom.equalToSuperview().offset(-Spacing.medium)
                $0.trailing.equalToSuperview().offset(-Spacing.medium)
            }
        }

        dividerView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}
