//
//  SwiftUIMomentListItemView.swift
//  Moments
//
//  Created by Jake Lin on 19/11/20.
//

import SwiftUI
import RxSwift
import struct Kingfisher.KFImage
import DesignKit

private struct IdentifiableURL: Identifiable {
    let url: URL
    let id = UUID()
}

private struct LikeToggleBackground<S: Shape>: View {
    var isHighlighted: Bool
    var shape: S

    //swiftlint:disable no_hardcoded_strings
    var body: some View {
        ZStack {
            if isHighlighted {
                shape
                    .fill(LinearGradient(Color("likeButtonFillEnd"), Color("likeButtonFillStart")))
                    .overlay(shape.stroke(LinearGradient(Color("likeButtonFillStart"), Color("likeButtonFillEnd")), lineWidth: 2))
                    .shadow(color: Color("likeButtonStart"), radius: 5, x: 5, y: 5)
                    .shadow(color: Color("likeButtonEnd"), radius: 5, x: -5, y: -5)
            } else {
                shape
                    .fill(LinearGradient(Color("likeButtonFillStart"), Color("likeButtonFillEnd")))
                    .overlay(shape.stroke(LinearGradient(Color("likeButtonFillStart"), Color("likeButtonFillEnd")), lineWidth: 2))
                    .shadow(color: Color("likeButtonStart"), radius: 5, x: 5, y: 5)
                    .shadow(color: Color("likeButtonEnd"), radius: 5, x: -5, y: -5)
            }
        }
    }
    //swiftlint:enable no_hardcoded_strings
}

private struct LikeToggleStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            configuration.label
                .padding(Spacing.extraSmall)
                .contentShape(Circle())
        })
        .background(
            LikeToggleBackground(isHighlighted: configuration.isOn, shape: Circle())
        )
    }
}

struct SwiftUIMomentListItemView: View {
    let viewModel: MomentListItemViewModel
    @EnvironmentObject var userDataStore: UserDataStoreObservableObject

    @State private var isLiked: Bool

    private let disposeBag: DisposeBag = .init()

    init(viewModel: MomentListItemViewModel) {
        self.viewModel = viewModel
        _isLiked = State(initialValue: viewModel.isLiked)
    }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            HStack(alignment: .top, spacing: Spacing.medium) {
                KFImage(viewModel.userAvatarURL)
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 44, height: 44)
                    .shadow(color: Color.primary.opacity(0.15), radius: 5, x: 0, y: 2)
                    .padding(.leading, Spacing.medium)

                VStack(alignment: .leading) {
                    Text(viewModel.userName)
                        .font(.subheadline)
                        .foregroundColor(.primary)

                    if let title = viewModel.title {
                        Text(title)
                            .font(.body)
                            .foregroundColor(Color.secondary)
                    }

                    if let photoURL = viewModel.photoURL {
                        KFImage(photoURL)
                            .resizable()
                            .frame(width: 240, height: 120)
                    }

                    if let postDateDescription = viewModel.postDateDescription {
                        Text(postDateDescription)
                            .font(.footnote)
                            .foregroundColor(Color.secondary)
                    }

                    if let likes = viewModel.likes, !likes.isEmpty {
                        HStack {
                            //swiftlint:disable no_hardcoded_strings
                            Image(systemName: "heart")
                                .foregroundColor(.secondary)
                            //swiftlint:enable no_hardcoded_strings
                            ForEach(likes.map { IdentifiableURL(url: $0) }) {
                                KFImage($0.url)
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .clipShape(Circle())
                                    .shadow(color: Color.primary.opacity(0.15), radius: 3, x: 0, y: 2)
                            }
                        }
                    }
                }
                Spacer()
            }

            Toggle(isOn: $isLiked) {
                //swiftlint:disable no_hardcoded_strings
                Image(systemName: "heart.fill")
                    .foregroundColor(isLiked == true ? Color("likeButtonSelected") : Color("likeButtonNotSelected"))
                    .animation(.easeIn)
                //swiftlint:enable no_hardcoded_strings
            }
            .toggleStyle(LikeToggleStyle())
            .padding(.trailing, Spacing.medium)
            .onChange(of: isLiked, perform: { isOn in
                guard isLiked == isOn else { return }
                if isOn {
                    viewModel.like(from: userDataStore.currentUser.userID).subscribe().disposed(by: disposeBag)
                } else {
                    viewModel.unlike(from: userDataStore.currentUser.userID).subscribe().disposed(by: disposeBag)
                }
            })
        }
        .frame(maxWidth:.infinity)
        .padding(EdgeInsets(top: Spacing.medium, leading: 0, bottom: Spacing.medium, trailing: 0))
        .background(BlurView(style: .systemMaterial))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color.black.opacity(0.15), radius: 20, x: 0, y: 20)
        .padding(.horizontal)
    }
}

private extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}
