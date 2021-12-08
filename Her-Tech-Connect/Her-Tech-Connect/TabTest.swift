//
//  TabTest.swift
//  Her-Tech-Connect
//
//  Created by Student Account on 10/24/21.
//

import SwiftUI

struct TabTest: View {
    var body: some View {
        
        TabView {
            
            HomePage().tabItem {
                Label("home", systemImage: "1.circle")
            }
            
            NetworkView().tabItem{
                Label("Network", systemImage: "person.3.fill")
            }
            
            EventView().tabItem {
                Label("events", systemImage: "2.circle")
            }
            
            ShoutOutView().tabItem {
                Label("Shout Out", systemImage: "megaphone")
            }
            
            MoreView().tabItem {
                Label("More", systemImage: "ellipsis")
            }
        }
    }
}

struct TabTest_Previews: PreviewProvider {
    static var previews: some View {
        TabTest()
    }
}
