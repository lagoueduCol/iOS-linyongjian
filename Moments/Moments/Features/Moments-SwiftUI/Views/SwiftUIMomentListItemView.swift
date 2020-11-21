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
    var id = UUID()
}

extension Color {
    static let offWhite = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)

    static let darkStart = Color(red: 50 / 255, green: 60 / 255, blue: 65 / 255)
    static let darkEnd = Color(red: 25 / 255, green: 25 / 255, blue: 30 / 255)

    static let lightStart = Color(red: 60 / 255, green: 160 / 255, blue: 240 / 255)
    static let lightEnd = Color(red: 30 / 255, green: 80 / 255, blue: 120 / 255)
}

struct LikeToggleBackground<S: Shape>: View {
    var isHighlighted: Bool
    var shape: S

    var body: some View {
        ZStack {
            if isHighlighted {
                shape
                    .fill(LinearGradient(Color.lightEnd, Color.lightStart))
                    .overlay(shape.stroke(LinearGradient(Color.lightStart, Color.lightEnd), lineWidth: 2))
                    .shadow(color: Color.darkStart, radius: 5, x: 5, y: 5)
                    .shadow(color: Color.darkEnd, radius: 5, x: -5, y: -5)
//                    .fill(Color.offWhite)
//                    .overlay(
//                        Circle()
//                            .stroke(Color.gray, lineWidth: 4)
//                            .blur(radius: 4)
//                            .offset(x: 2, y: 2)
//                            .mask(Circle().fill(LinearGradient(Color.black, Color.clear)))
//                    )
//                    .overlay(
//                        Circle()
//                            .stroke(Color.white, lineWidth: 8)
//                            .blur(radius: 4)
//                            .offset(x: -2, y: -2)
//                            .mask(Circle().fill(LinearGradient(Color.clear, Color.black)))
//                    )
            } else {
                shape
                    .fill(LinearGradient(Color.darkStart, Color.darkEnd))
                    .overlay(shape.stroke(LinearGradient(Color.lightStart, Color.lightEnd), lineWidth: 2))
                    .shadow(color: Color.darkStart, radius: 5, x: 5, y: 5)
                    .shadow(color: Color.darkEnd, radius: 5, x: -5, y: -5)
//                    .fill(Color.offWhite)
//                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
//                    .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
            }
        }
    }
}

struct LikeToggleStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            configuration.label
                .padding(8)
                .contentShape(Circle())
        })
        .background(
            LikeToggleBackground(isHighlighted: configuration.isOn, shape: Circle())
        )
    }
}

struct SwiftUIMomentListItemView: View {
    let viewModel: MomentListItemViewModel

    @State var isLiked: Bool
    @EnvironmentObject var userDataStore: UserDataStoreObservableObject

    private let disposeBag: DisposeBag = .init()

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
                    .foregroundColor(isLiked == true ? .red : .white)
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

//struct SwiftUIMomentListItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUIMomentListItemView()
//    }
//}
