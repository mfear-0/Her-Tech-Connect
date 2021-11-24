//
//  EventView.swift
//  Her-Tech-Connect
//
//  Created by Student Account on 10/24/21.
//

import SwiftUI
import UIKit
import MapKit


struct EventView: View {
    @StateObject private var viewModel = MapViewModel()
    @State private var addressField: String = ""
    //@State private var annotations = [MapPin(name:"Space Needle")]
    
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [MKPointAnnotation]()
    


    var body: some View {
        

        
        VStack{
            ZStack{
            
                MapView(centerCoordinate: $centerCoordinate, annotations: locations)
                .ignoresSafeArea()
                .onAppear {
                    viewModel.checkLocServ()
                }
            }
            //circle shows center coordinate that follows user as they zoom/pan
//            Circle()
//                .fill(Color.blue)
//                .frame(width: 10, height: 10)}

            //old map view code, don't remove yet.
            
//            Map(
//                coordinateRegion: $viewModel.region,
//                showsUserLocation: true,
//                annotationItems: annotations,
//                annotationContent: { item in
//                    MapMarker(coordinate: item.coordinate)
//                }
//
//            )
//                .accentColor(Color(.systemPink))
//                //.frame(width: 400, height: 600, alignment: .center)
//                .onAppear {
//                    viewModel.checkLocServ()
//
//                }
                

            HStack {
                Spacer()
                TextField(" Event Address", text: $addressField)
                    .background(Color(.white))
                Spacer()
                Button(action: {
                    let newLocation = MKPointAnnotation()
                    print("button pressed")
                    if (addressField == ""){
                        return
                    }
                    let geocoder = CLGeocoder()
                    geocoder.geocodeAddressString(addressField) {
                        placemarks, error in
                        let placemark = placemarks?.first
                        let lat = placemark?.location?.coordinate.latitude
                        let long = placemark?.location?.coordinate.longitude
                        newLocation.coordinate = CLLocationCoordinate2D(latitude:lat!, longitude: long!)
                        self.locations.append(newLocation)
                        print("button pressed. address coordinates are: \(newLocation.coordinate.latitude) and \(newLocation.coordinate.longitude)")
                        
                    }
                    
                    
                    
                }, label: {
                    Text("Add Event")
                })
                .padding()
            }
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
