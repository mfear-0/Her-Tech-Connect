//
//  EventView.swift
//  Her-Tech-Connect
//
//  Created by Student Account on 10/24/21.
//

import SwiftUI

struct EventView: View {
    var body: some View {
        
        VStack{
            Text("Event View")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemTeal).ignoresSafeArea())
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView()
    }
}
