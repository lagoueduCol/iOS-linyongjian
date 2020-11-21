//
//  SwiftUIMomentListItemView.swift
//  Moments
//
//  Created by Jake Lin on 19/11/20.
//

import SwiftUI
import struct Kingfisher.KFImage
import DesignKit

private struct IdentifiableURL: Identifiable {
    let url: URL
    var id = UUID()
}

struct SwiftUIMomentListItemView: View {
    let viewModel: MomentListItemViewModel

    var body: some View {
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
        .frame(maxWidth:.infinity)
        .padding(EdgeInsets(top: Spacing.medium, leading: 0, bottom: Spacing.medium, trailing: 0))
        .background(BlurView(style: .systemMaterial))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color.black.opacity(0.15), radius: 20, x: 0, y: 20)
        .padding(.horizontal)
    }
}

//struct SwiftUIMomentListItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUIMomentListItemView()
//    }
//}
