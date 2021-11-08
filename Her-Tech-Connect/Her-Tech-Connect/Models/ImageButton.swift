//
//  ImageButton.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 11/7/21.
//

import SwiftUI

struct ImageButton: View {
    var image: String
    var imageWidth: CGFloat
    var imageHeight: CGFloat
    var body: some View {
        Image(systemName: image)
            .resizable()
            .frame(width: imageWidth, height: imageHeight)
            .foregroundColor(.black)
    }
}

struct ImageButton_Previews: PreviewProvider {
    static var previews: some View {
        ImageButton(image: "bell.fill", imageWidth: 20, imageHeight: 20)
    }
}
