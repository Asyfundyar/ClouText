//
//  Locationer.swift
//  ClouText
//
//  Created by user203974 on 11/10/21.
//

import Foundation
import CoreLocation

class Locationer : NSObject, ObservableObject, CLLocationManagerDelegate {
    var lm = CLLocationManager()
    @Published var location = CLLocationCoordinate2D(latitude: 38.9897, longitude: -76.9378)
    
    override init() {
        super.init()
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyBest
        lm.distanceFilter = 4
        lm.requestWhenInUseAuthorization()
        lm.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loc = locations.last {
            location = CLLocationCoordinate2D(latitude: loc.coordinate.latitude, longitude: loc.coordinate.longitude)
        }
    }
}
