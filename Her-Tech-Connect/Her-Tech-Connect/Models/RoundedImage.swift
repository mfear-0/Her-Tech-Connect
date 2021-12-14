//
//  RoundedImage.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 11/7/21.
//

import SwiftUI

struct RoundedImage: View {
    var urlImage: String
    var imageWidth: CGFloat
    var imageHeight: CGFloat
    var body: some View {
        if #available(iOS 15.0, *) {
            AsyncImage(url: URL(string: urlImage), content: { image in
                image.resizable()
                    .scaledToFill()
                    .frame(width: imageWidth, height: imageHeight)
                    .clipShape(Circle())
                    .shadow(radius: 10)
//                    .overlay(Circle().stroke(Color.red, lineWidth: 2))
                
            },
            placeholder: {
                ProgressView()
            })
        } else {
            // Fallback on earlier versions
        }
    }
}

struct RoundedImage_Previews: PreviewProvider {
    static var previews: some View {
        RoundedImage(urlImage: "https://cdn.iconscout.com/icon/free/png-256/account-avatar-profile-human-man-user-30448.png", imageWidth: 100.0, imageHeight: 100.0)
    }
}
