//
//  SwiftUIUserProfileListItemView.swift
//  Moments
//
//  Created by Jake Lin on 19/11/20.
//

import SwiftUI
import struct Kingfisher.KFImage

struct SwiftUIUserProfileListItemView: View {
    let viewModel: UserProfileListItemViewModel
    @Binding var isDragging: Bool

    @State private var viewSize: CGSize = .zero

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text(viewModel.name)
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(.trailing, 10)
                KFImage(viewModel.avatarURL)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80, alignment: .center)
                    .clipShape(Circle())
            }
            .padding(.trailing, 10)
            .padding(.bottom, 10)
        }
        .frame(height: 350)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                Image(uiImage: #imageLiteral(resourceName: "Blob"))
                    .offset(x: -200, y: -200)
                    .rotationEffect(Angle(degrees: 450))
                    .blendMode(.plusDarker)
                Image(uiImage: #imageLiteral(resourceName: "Blob"))
                    .offset(x: -200, y: -250)
                    .rotationEffect(Angle(degrees: 360), anchor: .leading)
                    .blendMode(.overlay)
            }
        )
        .background(
            KFImage(viewModel.backgroundImageURL)
                .resizable()
                .offset(x: viewSize.width / 20, y: viewSize.height / 20)
        )
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .scaleEffect(isDragging ? 0.9 : 1)
        .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
        .rotation3DEffect(Angle(degrees: 5), axis: (x: viewSize.width, y: viewSize.height, z: 0))
        .gesture(
            DragGesture().onChanged({ value in
                // Seems there is bug: `onChanged` will be called after `onEnded`, will fix later
                self.isDragging = true
                self.viewSize = value.translation
            }).onEnded({ _ in
                self.isDragging = false
                self.viewSize = .zero
            })
        )
    }
}

struct SwiftUIUserProfileListItemView_Previews: PreviewProvider {
    @State private static var isDragging = false

    static var previews: some View {
        //swiftlint:disable no_hardcoded_strings
        SwiftUIUserProfileListItemView(viewModel: UserProfileListItemViewModel(userDetails: MomentsDetails.UserDetails(id: "1", name: "Jake Lin", avatar: "https://avatars0.githubusercontent.com/u/573856?s=460&v=4", backgroundImage: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg")), isDragging: $isDragging)
        //swiftlint:enable no_hardcoded_strings
    }
}
