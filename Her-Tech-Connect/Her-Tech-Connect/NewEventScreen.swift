//
//  NewEventScreen.swift
//  Her-Tech-Connect
//
//  Created by Student Account on 4/21/22.
//

import SwiftUI
import MapKit
import UIKit
import FirebaseAuth
import FirebaseDatabase

struct EventObj: Identifiable {
    let id : String
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
    @State private var currentUserId = ""
    let ref = Database.database().reference()
    @State var event: EventObj
    
    var body: some View {
        Text("Event details for : \(event.name)")
        Text(event.loc)
        Text(event.date)
        
        MapView(centerCoordinate: $centerCoordinate, annotations: locations)

            .onAppear(perform: {
                ref.child("Users").observeSingleEvent(of: .value, with: {(users) in
                    for aUser in users.children {
                        let snap = aUser as! DataSnapshot
                        let userDict = snap.value as! [String: Any]
                        let userEmail = userDict["email"] as! String
                        if userEmail == Auth.auth().currentUser!.email {
                            self.currentUserId = userDict["userId"] as! String
                        }
                    }
                })
            })
        .ignoresSafeArea()
        //.onAppear {
        //    viewModel.checkLocServ()
        //}
        
        Spacer()
        if #available(macOS 12.0, *) {
            if #available(iOS 15.0, *) {
                Button("Schedule Event") {

                    EventHandler.schedEvent(userId: self.currentUserId, eventId: self.event.id)
                    
                    showingAlert = true
                    
                }
                .alert("Event added to user schedule", isPresented: $showingAlert){
                    Button("OK", role: .cancel){
                }
            }
            } else {
                // Fallback on earlier versions
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
    @Binding var isPresented: Bool
    
    var body: some View {
        //code for adding new event.
        //Text("Nothing here yet?")
        
        VStack{
            Text("Add new Event").font(.title2)
                .padding(.all)
            HStack{
            Text("Event Name")
                .padding(.all)
            TextField(" Event Name", text: $nameField)
                .padding(.all)
                .background(Color(.white))
                .textFieldStyle(RoundedBorderTextFieldStyle())}
            
            HStack{
            Text("Event Address")
                .padding(.all)
            TextField(" Event Address", text: $addressField)
                .padding(.all)
                .background(Color(.white))
                .textFieldStyle(RoundedBorderTextFieldStyle())}
            
            DatePicker("date:", selection: $dateField, displayedComponents: [.date])
                .padding(.all)
                .labelsHidden()
            DatePicker("time:", selection: $timeField, displayedComponents: [.hourAndMinute])
                .padding(.all)
                .labelsHidden()
        }
        Button(action: {
            let newLocation = MKPointAnnotation()
            print("button pressed")
            if (addressField == ""){
                isPresented = false
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
                if placemark == nil {
                    isPresented = false
                    return
                }
                let lat = placemark?.location?.coordinate.latitude
                let long = placemark?.location?.coordinate.longitude
                newLocation.coordinate = CLLocationCoordinate2D(latitude:lat!, longitude: long!)

                self.locations.append(newLocation)
                //print("button pressed. address coordinates are: \(newLocation.coordinate.latitude) and \(newLocation.coordinate.longitude)")

            }
            let newEvent = EventObj(id: UUID().uuidString, name: nameField, loc: addressField, time: formatter2.string(from: timeField), date: formatter1.string(from: dateField))
            //eh.tempAdd(newEvent: newEvent)

            EventHandler.addEvent(name: newEvent.name, address: newEvent.loc, date: newEvent.date, time: newEvent.time)
            //dump(eventArray)
            
            nameField = ""
            addressField = ""
            isPresented = false
            
            
        }, label: {
            Text("Add Event")
        })
            .padding(.all)
        
    }
}

struct NewEventScreen: View {
    
    @State private var eventArray = [EventObj]()
    @State private var addForm = false
    
    let ref = Database.database().reference()
    
    // In the future, grab actual event details from firebase store
//    let events = [
//        EventObj(name:"Event 1", loc:"400 broad street, seattle", time: " 5 pm", date:"01/01/2023"),
//        EventObj(name:"Event 2", loc:"1701 broadway, seattle", time: " 5 pm", date:"02/01/2023"),
//        EventObj(name:"Event 3", loc:"1912 pike pl, seattle", time: " 5 pm", date:"03/01/2023"),
//    ]
    
    var body: some View {
        NavigationView {
            List(eventArray) {event in
                NavigationLink(destination: EventDetail(event: event)) {
                    Text(event.name)
                    
                }
            }
            .navigationTitle("Select an Event")
            .toolbar{
                Button(action: {
                    self.addForm.toggle()
                }) {
                    Text("Add Event")
                }.sheet(isPresented: $addForm){
                    AddEventView(isPresented: $addForm)
                }
            }
        }
        .onAppear(perform: {
            if eventArray.isEmpty{
                ref.child("Events").observeSingleEvent(of: .value, with: {(events) in
                    for event in events.children{
                        let snap = event as! DataSnapshot
                        let eventDict = snap.value as! [String: Any]
                        
                        let ev = EventObj(id:eventDict["eventID"] as! String, name: eventDict["name"] as! String, loc: eventDict["address"] as! String, time: eventDict["time"] as! String, date: eventDict["date"] as! String)
                        
                        self.eventArray.append(ev)
                        print(ev)
                        
                    }
                    
                })
            }
        })

}

struct NewEventScreen_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}
