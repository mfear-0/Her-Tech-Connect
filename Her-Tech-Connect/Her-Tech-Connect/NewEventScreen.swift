//
//  NewEventScreen.swift
//  Her-Tech-Connect
//
//  Created by Student Account on 4/21/22.
//

import SwiftUI
import MapKit

struct EventObj: Identifiable {
    let id = UUID()
    let name: String
    let loc: String
    let date: String
    //let coord: nav coordinates data type from data store
}

struct EventDetail: View {
    @State private var showingAlert = false
    var event: EventObj
    
    var body: some View {
        Text("Event details for : \(event.name)")
        Text(event.loc)
        Text(event.date)
        
        // add implanted map view that displays location from event.coord
        
        Spacer()
        if #available(macOS 12.0, *) {
            Button("Schedule Event") {
                
                // IMPORTANT
                // place actual code here to check user status and add
                // event to their schedules.
                // IMPORTANT
                
                showingAlert = true
            }
            .alert("Event added to user schedule", isPresented: $showingAlert){
                Button("OK", role: .cancel){}
            }
        } else {
            // Fallback on earlier versions
            // no idea what to do here lmao
        }
    }
}



struct NewEventScreen: View {
    
    // In the future, grab actual event details from firebase store
    let events = [
        EventObj(name:"Event 1", loc:"123 main street", date:"01/01/2023"),
        EventObj(name:"Event 2", loc:"456 main street", date:"02/01/2023"),
        EventObj(name:"Event 3", loc:"789 main street", date:"03/01/2023"),
    ]
    
    var body: some View {
        NavigationView {
            List(events) {event in
                NavigationLink(destination: EventDetail(event: event)) {
                    Text(event.name)
                    
                }
            }
            .navigationTitle("Select an Event")
        }

}

struct NewEventScreen_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}
