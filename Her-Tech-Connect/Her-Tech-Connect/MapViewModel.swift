//
//  MapViewModel.swift
//  Her-Tech-Connect
//
//  Created by Student Account on 11/1/21.
//

import MapKit

enum MapDet {
    static let startLoc = CLLocationCoordinate2D(latitude: 47.6062, longitude: -122.3321)
    static let startSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    //@State private var showAlert = false
    @Published var region = MKCoordinateRegion(center: MapDet.startLoc, span: MapDet.startSpan)
    var locManager: CLLocationManager?
    
    
    func checkLocServ() {
        if CLLocationManager.locationServicesEnabled() {
            locManager = CLLocationManager()
            locManager?.delegate = self
        } else {
            //showAlert = true
            print("loc serv disabled")
        }

    }
    
    private func checkLocAuth() {
        guard let locManager = locManager else {
            return
        }
        
        switch locManager.authorizationStatus{
            
        case .notDetermined:
            locManager.requestWhenInUseAuthorization()
        case .restricted:
            print("location restricted")
        case .denied:
            print("location denied for this app")
        case .authorizedAlways, .authorizedWhenInUse:
            
            region = MKCoordinateRegion(center: locManager.location?.coordinate ?? MapDet.startLoc, span:MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            
        @unknown default:
            break
        }

    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocAuth()
    }
}
