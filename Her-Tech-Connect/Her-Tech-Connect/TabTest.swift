//
//  TabTest.swift
//  Her-Tech-Connect
//
//  Created by Student Account on 10/24/21.
//  Modified by Arica Conrad on 12/15/21.

import SwiftUI

struct TabTest: View {
    var body: some View {
        
        TabView {
            
            HomePage().tabItem {
                Label("Home", systemImage: "house")
            }
            
            NetworkView().tabItem{
                Label("Network", systemImage: "person.3.fill")
            }
            
            EventView().tabItem {
                Label("Events", systemImage: "mappin.and.ellipse")
            }
            
            ShoutOutView().tabItem {
                Label("Shout Outs", systemImage: "megaphone")
            }
            
            MoreView().tabItem {
                Label("More", systemImage: "line.horizontal.3")
            }
        }
    }
}

struct TabTest_Previews: PreviewProvider {
    static var previews: some View {
        TabTest()
    }
}
