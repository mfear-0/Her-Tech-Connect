//
//  ImageButton.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 11/7/21.
//

import SwiftUI

struct ImageButton: View {
    @Environment(\.colorScheme) var colorScheme
    var image: String
    var imageWidth: CGFloat
    var imageHeight: CGFloat
    var body: some View {
        Image(systemName: image)
            .resizable()
            .frame(width: imageWidth, height: imageHeight)
            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
    }
}

struct ImageButton_Previews: PreviewProvider {
    static var previews: some View {
        ImageButton(image: "bell.fill", imageWidth: 20, imageHeight: 20)
    }
}
