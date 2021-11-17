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
    


    var body: some View {
        
        
        
        VStack{
            let MapPins = [
                viewModel.PinOne
            ]
            Map(
                coordinateRegion: $viewModel.region,
                showsUserLocation: true,
                annotationItems: MapPins,
                annotationContent: { item in
                    MapMarker(coordinate: item.coordinate)
                }
                
            )
                .onAppear {
                    viewModel.checkLocServ()
                }
                .accentColor(Color(.systemPink))
                .frame(width: 400, height: 600, alignment: .center)

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
