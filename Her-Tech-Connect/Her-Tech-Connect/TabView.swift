//
//  TabView.swift
//  Her-Tech-Connect
//
//  Created by Student Account on 10/24/21.
//

import SwiftUI

struct TabView: View {
    var body: some View {
        TabView {

            Text("Test").tabItem {
                Text("Item 1")
            }
        }

    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabView()
    }
}
