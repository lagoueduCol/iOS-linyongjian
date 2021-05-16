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
        $0.font = UIFont.designKit.title3
        $0.textColor = UIColor.designKit.primaryText
        $0.numberOfLines = 1
    }

    private let titleLabel: UILabel = configure(.init()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.designKit.background
        $0.font = UIFont.designKit.body
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
        $0.font = UIFont.designKit.small
        $0.textColor = UIColor.designKit.tertiaryText
        $0.numberOfLines = 1
    }

    private let likesContainerView: UIView = configure(.init()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.designKit.secondaryBackground
        $0.layer.cornerRadius = 4
    }

    private let likesStakeView: UIStackView = configure(.init()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.spacing = Spacing.twoExtraSmall
    }

    private let favoriteButton: UIButton = configure(.init()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.asHeartFavoriteButton()
    }

    private let dividerView: UIView = configure(.init()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.designKit.line
    }

    private let userDataStore: UserDataStoreType
    private let togglesDataStore: TogglesDataStoreType
    private let remoteTogglesDataStore: TogglesDataStoreType
    private let abTestProvider: ABTestProvider
    private var viewModel: MomentListItemViewModel?

    override convenience init(frame: CGRect = .zero) {
        self.init(frame: frame, userDataStore: UserDataStore.current)
    }

    init(frame: CGRect = .zero, userDataStore: UserDataStoreType = UserDataStore.current, togglesDataStore: TogglesDataStoreType = InternalTogglesDataStore.shared, remoteTogglesDataStore: TogglesDataStoreType = FirebaseRemoteTogglesDataStore.shared, abTestProvider: ABTestProvider = FirebaseABTestProvider.shared) {
        self.userDataStore = userDataStore
        self.togglesDataStore = togglesDataStore
        self.remoteTogglesDataStore = remoteTogglesDataStore
        self.abTestProvider = abTestProvider
        super.init(frame: frame)

        setupUI()
        setupConstraints()
        setupBindings()
    }

    // swiftlint:disable unavailable_function
    required init?(coder aDecoder: NSCoder) {
        fatalError(L10n.Development.fatalErrorInitCoderNotImplemented)
    }
    // swiftlint:enable unavailable_function

    override func update(with viewModel: ListItemViewModel) {
        guard let viewModel = viewModel as? MomentListItemViewModel else {
            return
        }

        self.viewModel = viewModel
        userAvatarImageView.kf.setImage(with: viewModel.userAvatarURL)
        userNameLabel.text = viewModel.userName
        titleLabel.text = viewModel.title
        momentImageView.kf.setImage(with: viewModel.photoURL)
        postDateDescriptionLabel.text = viewModel.postDateDescription

        if togglesDataStore.isToggleOn(InternalToggle.isLikeButtonForMomentEnabled) {
            favoriteButton.isSelected = viewModel.isLiked

            likesStakeView.arrangedSubviews.forEach {
                $0.removeFromSuperview()
            }
            likesContainerView.isHidden = viewModel.likes.isEmpty

            if !viewModel.likes.isEmpty {
                likesStakeView.addArrangedSubview(likeImageView)
            }
            viewModel.likes.forEach {
                let avatarURL = $0
                let avatarImageView: UIImageView = configure(.init()) {
                    $0.translatesAutoresizingMaskIntoConstraints = false
                    $0.asAvatar(cornerRadius: 2)
                    $0.kf.setImage(with: avatarURL)
                }

                avatarImageView.snp.makeConstraints {
                    $0.width.equalTo(20)
                    $0.height.equalTo(20)
                }

                if remoteTogglesDataStore.isToggleOn(RemoteToggle.isRoundedAvatar) {
                    avatarImageView.asAvatar(cornerRadius: 10)
                }
                likesStakeView.addArrangedSubview(avatarImageView)
            }
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

        if togglesDataStore.isToggleOn(InternalToggle.isLikeButtonForMomentEnabled) {
            likesContainerView.addSubview(likesStakeView)
            verticalStackView.addArrangedSubview(likesContainerView)
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
            $0.leading.top.equalToSuperview().offset(Spacing.medium)
            $0.bottom.trailing.equalToSuperview().offset(-Spacing.medium)
        }

        // Add `favoriteButton` if the toggle is ON
        if togglesDataStore.isToggleOn(InternalToggle.isLikeButtonForMomentEnabled) {
            // Set the like button style
            switch abTestProvider.likeButtonStyle {
            case .heart:
                favoriteButton.asHeartFavoriteButton()
            case .star:
                favoriteButton.asStarFavoriteButton()
            case .none:
                // If the remote config is not set
                favoriteButton.asHeartFavoriteButton()
            }

            addSubview(favoriteButton)
        }

        // Round the avatar if the remote toggle is on
        if remoteTogglesDataStore.isToggleOn(RemoteToggle.isRoundedAvatar) {
            userAvatarImageView.asAvatar(cornerRadius: 20)
        }
    }

    func setupConstraints() {
        userAvatarImageView.snp.makeConstraints {
            $0.height.width.equalTo(40)
        }

        momentImageView.snp.makeConstraints {
            $0.height.equalTo(120)
            $0.width.equalTo(240)
        }

        if togglesDataStore.isToggleOn(InternalToggle.isLikeButtonForMomentEnabled) {
            likesStakeView.snp.makeConstraints {
                $0.top.leading.equalToSuperview().offset(Spacing.twoExtraSmall)
                $0.bottom.trailing.equalToSuperview().offset(-Spacing.twoExtraSmall)
            }

            favoriteButton.snp.makeConstraints {
                $0.bottom.trailing.equalToSuperview().offset(-Spacing.medium)
            }
        }

        dividerView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }

    func setupBindings() {
        if togglesDataStore.isToggleOn(InternalToggle.isLikeButtonForMomentEnabled) {
            favoriteButton.rx.tap
                .bind(onNext: { [weak self] in
                    guard let self = self else { return }
                    if self.favoriteButton.isSelected {
                        self.viewModel?.like(from: self.userDataStore.userID).subscribe().disposed(by: self.disposeBag)
                    } else {
                        self.viewModel?.unlike(from: self.userDataStore.userID).subscribe().disposed(by: self.disposeBag)
                    }
                })
                .disposed(by: disposeBag)
        }
    }
}

private extension MomentListItemView {
    var likeImageView: UIImageView {
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 16, weight: .light, scale: .default)
        // swiftlint:disable no_hardcoded_strings
        let heartImage = UIImage(systemName: "heart", withConfiguration: symbolConfiguration)
        // swiftlint:enable no_hardcoded_strings
        return configure(.init(image: heartImage)) {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.tintColor = UIColor.designKit.secondaryText
        }
    }
}
