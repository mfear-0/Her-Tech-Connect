//
//  EventView.swift
//  Her-Tech-Connect
//
//  Created by Student Account on 10/24/21.
//  Modified by Arica Conrad on 12/15/21.
//

import SwiftUI
import UIKit
import MapKit


struct EventView: View {
    @StateObject private var viewModel = MapViewModel()
    @State private var addressField: String = ""
    @State private var nameField: String = ""
    @State private var timeField = Date()
    @State private var dateField = Date()
    @Environment(\.colorScheme) var colorScheme
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [MKPointAnnotation]()
    @State private var eventArray = [eventObject]()
    private class eventObject {
        var eName: String = ""
        var eAddress: String = ""
        var eTime: String = ""
        var eDate: String = ""
    }

    var body: some View {

        VStack{
            ZStack{
            
                MapView(centerCoordinate: $centerCoordinate, annotations: locations)
                .ignoresSafeArea()
                .onAppear {
                    viewModel.checkLocServ()
                }
            }
                

            HStack {
                Spacer()
                VStack{
                TextField(" Event Name", text: $nameField)
                        .background(colorScheme == .dark ? Color.black : Color.white)
                TextField(" Event Address", text: $addressField)
                        .background(colorScheme == .dark ? Color.black : Color.white)
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
                    let newEvent = eventObject()
                    newEvent.eName = nameField
                    newEvent.eAddress = addressField
                    newEvent.eDate = formatter1.string(from: dateField)
                    newEvent.eTime = formatter2.string(from: timeField)
                    EventHandler.addEvent(name: newEvent.eName, address: newEvent.eAddress, date: newEvent.eDate, time: newEvent.eTime)
                    //eventArray.append(newEvent)
                    //dump(eventArray)
                    
                    nameField = ""
                    addressField = ""
                    
                    
                }, label: {
                    Text("Add Event")
                })
                .padding()
            }
            Text("Event View")

        }
        .background(Color("White").ignoresSafeArea())
    }
    


}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView()
    }
}
