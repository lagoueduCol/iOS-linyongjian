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

    @State private var viewState = CGSize.zero
    @Binding var isDragging: Bool

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text(viewModel.name)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.trailing, 10)
                KFImage(viewModel.avatarURL)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80, alignment: .top)
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
        .background(KFImage(viewModel.backgroundImageURL)
        .offset(x: viewState.width / 25, y: viewState.height / 25))
        .background(Color(#colorLiteral(red: 0.4117647059, green: 0.4705882353, blue: 0.9725490196, alpha: 1)))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .scaleEffect(isDragging ? 0.9 : 1)
        .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
        .rotation3DEffect(Angle(degrees: 5), axis: (x: viewState.width, y: viewState.height, z: 0))
        .gesture(
            DragGesture().onChanged({ value in
                // Seems there is bug `onChanged` will be called after `onEnded`, will fix later
                self.isDragging = true
                self.viewState = value.translation
            }).onEnded({ _ in
                self.isDragging = false
                self.viewState = .zero
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
