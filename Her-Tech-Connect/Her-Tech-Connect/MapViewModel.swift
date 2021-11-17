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

struct MapPin: Identifiable {
    let id = UUID()
    let name:String
    let mplat:Double = defLat
    let mplong:Double = defLong
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: mplat, longitude: mplong)
    }
}

var defLat: Double = 47.6205
var defLong: Double = 122.3493

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    //@State private var showAlert = false
    @Published var region = MKCoordinateRegion(center: MapDet.startLoc, span: MapDet.startSpan)
    @Published var PinOne = MapPin(name:"Space Needle")
    
    
    var locManager: CLLocationManager?
    
    func setAddressPin(addressString: String/*, addressName: String*/ ){
        getCoord(from: addressString) { coordinates in
            print(coordinates!)
            defLat = coordinates!.latitude
            defLong = coordinates!.longitude
            
        }
    }
    
    func getCoord(from addressString: String, completionHandler: @escaping(_ location: CLLocationCoordinate2D?) -> Void ) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            guard let placemarks = placemarks,
                  let location = placemarks.first?.location?.coordinate else {
                      completionHandler(nil)
                      return
                  }
            completionHandler(location)
        }
    }
    
    
    
    
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
