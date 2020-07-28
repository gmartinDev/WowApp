//
//  PullImageView.swift
//  WowApp
//
//  Created by Greg Martin on 7/22/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import SwiftUI
import URLImage

struct PullImageView: View {
    let imageName: String
    var body: some View {
        Image(imageName).PullImageViewModifier()
    }
}

struct PullURLImageView: View {
    let imageUrl: URL
    
    var body: some View {
        URLImage(imageUrl, placeholder: {
            _ in Image("mountPlaceholderImg").PullImageViewModifier()
        }, content: {
            $0.image.PullImageViewModifier()
        })
    }
}

private extension Image {
    func PullImageViewModifier() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 200)
            .background(Color.clear)
    }
}

struct PullImageView_Previews: PreviewProvider {
    static var previews: some View {
        PullImageView(imageName: "mountPlaceholderImg")
    }
}
