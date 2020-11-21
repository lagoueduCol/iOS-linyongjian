//
//  SwiftUIMomentListItemView.swift
//  Moments
//
//  Created by Jake Lin on 19/11/20.
//

import SwiftUI
import struct Kingfisher.KFImage
import DesignKit

struct SwiftUIMomentListItemView: View {
    let viewModel: MomentListItemViewModel

    var body: some View {
        HStack(alignment: .top, spacing: Spacing.medium) {
            KFImage(viewModel.userAvatarURL)
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 44, height: 44)
                    .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
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
