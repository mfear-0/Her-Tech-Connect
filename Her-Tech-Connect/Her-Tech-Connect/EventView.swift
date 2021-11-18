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
    @State private var annotations = [MapPin(name:"Space Needle")]
    
    //func updateAnno() {
    //    let newAnno = viewModel.PinOne
    //    annotations = [newAnno]
    //}

    var body: some View {
        

        
        VStack{
            
            Map(
                coordinateRegion: $viewModel.region,
                showsUserLocation: true,
                annotationItems: annotations,
                annotationContent: { item in
                    MapMarker(coordinate: item.coordinate)
                }
                
            )
                .onAppear {
                    viewModel.checkLocServ()

                }
                .accentColor(Color(.systemPink))
                .frame(width: 400, height: 600, alignment: .center)

            HStack {
                Spacer()
                TextField(" Event Address", text: $addressField)
                    .background(Color(.white))
                Spacer()
                Button(action: {
                    print("button pressed")
                    if (addressField == ""){
                        return
                    }
                    viewModel.setAddressPin(addressString: addressField)
                    //updateAnno()
                    
                }, label: {
                    Text("Add Event")
                })
                .padding()
                //.font(.title)
                //.clipShape(Circle())
                //.padding(.trailing)
            }
            //Spacer()
            Text("Event View")

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color(.systemTeal).ignoresSafeArea())
        
    }
    


}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView()
    }
}
