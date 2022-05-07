//
//  NewEventScreen.swift
//  Her-Tech-Connect
//
//  Created by Student Account on 4/21/22.
//

import SwiftUI
import MapKit
import UIKit

struct EventObj: Identifiable {
    let id = UUID()
    let name: String
    let loc: String
    let time: String
    let date: String
    //let coord: nav coordinates data type from data store
}


struct EventDetail: View {
    @State private var showingAlert = false
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [MKPointAnnotation]()
    var event: EventObj
    
    var body: some View {
        Text("Event details for : \(event.name)")
        Text(event.loc)
        Text(event.date)
        
        mapview(centerCoordinate: $centerCoordinate, annotations: locations)
        .ignoresSafeArea()
        //.onAppear {
        //    viewModel.checkLocServ()
        //}
        
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

struct AddEventView: View {
    
    @StateObject private var viewModel = MapViewModel()
    @State private var addressField: String = ""
    @State private var nameField: String = ""
    @State private var timeField = Date()
    @State private var dateField = Date()
    @State private var locations = [MKPointAnnotation]()
    
    var body: some View {
        //code for adding new event.
        //Text("Nothing here yet?")
        
        VStack{
        TextField(" Event Name", text: $nameField)
            .background(Color(.white))
        TextField(" Event Address", text: $addressField)
                .background(Color(.white))
        DatePicker("date:", selection: $dateField, displayedComponents: [.date])
            .labelsHidden()
        DatePicker("time:", selection: $timeField, displayedComponents: [.hourAndMinute])
                .labelsHidden()
        }
        Spacer()
        Button(action: {
            let newLocation = MKPointAnnotation()
            print("button pressed")
            if (addressField == ""){
                return
            }
            let formatter1 = DateFormatter()
            formatter1.dateStyle = .short
            let formatter2 = DateFormatter()
            formatter2.timeStyle = .short

            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(addressField) {
                placemarks, error in
                let placemark = placemarks?.first
                let lat = placemark?.location?.coordinate.latitude
                let long = placemark?.location?.coordinate.longitude
                newLocation.coordinate = CLLocationCoordinate2D(latitude:lat!, longitude: long!)
                self.locations.append(newLocation)
                //print("button pressed. address coordinates are: \(newLocation.coordinate.latitude) and \(newLocation.coordinate.longitude)")
                
            }
            let newEvent = EventObj(name: nameField, loc: addressField, time: formatter2.string(from: timeField), date: formatter1.string(from: dateField))

            //EventHandler.addEvent(name: newEvent.eName, address: newEvent.eAddress, date: newEvent.eDate, time: newEvent.eTime)
            //eventArray.append(newEvent)
            //dump(eventArray)
            
            nameField = ""
            addressField = ""
            
            
        }, label: {
            Text("Add Event")
        })
        
    }
}

struct NewEventScreen: View {
    
    @State private var eventArray = [EventObj]()
    
    // In the future, grab actual event details from firebase store
    let events = [
        EventObj(name:"Event 1", loc:"123 main street", time: " 5 pm", date:"01/01/2023"),
        EventObj(name:"Event 2", loc:"456 main street", time: " 5 pm", date:"02/01/2023"),
        EventObj(name:"Event 3", loc:"789 main street", time: " 5 pm", date:"03/01/2023"),
    ]
    
    var body: some View {
        NavigationView {
            List(events) {event in
                NavigationLink(destination: EventDetail(event: event)) {
                    Text(event.name)
                    
                }
            }
            .navigationTitle("Select an Event")
            //.toolbar{
                //NavigationLink(destination: AddEventView){
                    //Text("Create Event")
                    
                //}
            //}
        }

}

struct NewEventScreen_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}