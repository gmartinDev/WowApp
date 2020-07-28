//
//  CircularImageView.swift
//  WowApp
//
//  Created by Greg Martin on 7/14/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import SwiftUI
import URLImage

struct CircularImageView: View {
    let imageName: String
    var body: some View {
        Image(imageName).CircularImageModifier()
    }
}

struct CircularURLImageView: View {
    let imageURL: URL
    var body: some View {
        URLImage(imageURL, placeholder: {
            _ in
            Image("placeholderImage").CircularImageModifier()
        }, content: {
            $0.image.CircularImageModifier()
        })
    }
}

private extension Image {
    func CircularImageModifier() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
            .frame(width: 100.0, height: 100.0)
    }
}

struct CircularImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircularImageView(imageName: "achievementIcon")
    }
}
