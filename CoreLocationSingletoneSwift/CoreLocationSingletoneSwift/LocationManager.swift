//
//  LocationManager.swift
//  CoreLocationSingletoneSwift
//
//  Created by Mikhail Pchelnikov on 08/11/14.
//  Copyright (c) 2014 Mikhail Pchelnikov. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    class var shared : LocationManager {
        
        struct Static {
            static let instance : LocationManager = LocationManager()
        }
        
        return Static.instance
    }
    
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    var currentLocation = CLLocation()
    var currentLocationText: String?
    
    override init() {
        super.init()
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
                case .Authorized:
                    // Yes, always
                    createLocationManager()
                case .AuthorizedWhenInUse:
                    // Yes, only when our app is in use
                    createLocationManager()
                case .Denied:
                    // NO
                    displayAlertWithTitle("Not Determined", message: "Location services are not allowed for this app")
                case .NotDetermined:
                    // Ask for access
                    createLocationManager()
                    locationManager.requestWhenInUseAuthorization()
                case .Restricted:
                    // Have no access to location services
                    displayAlertWithTitle("Restricted", message: "Location services are not allowed for this app")
            }
        } else {
            displayAlertWithTitle("Not Enabled", message: "Location services are not enabled on this device")
        }
    }
    
    func displayAlertWithTitle(title: String, message: String) {
        var alert = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "OK")
        
        alert.show()
    }
    
    func createLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        locationManager.stopUpdatingLocation()
        
        if error != nil {
            println(error)
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var locationArray = locations as NSArray
        
        currentLocation = locationArray.lastObject as CLLocation
        
        geocoder.reverseGeocodeLocation(currentLocation, completionHandler: {(placemarks, error) -> Void in
            if error != nil {
                println("Error: \(error)")
            } else {
                var placemarksArray = placemarks as NSArray
                var placemark = placemarksArray.lastObject as CLPlacemark
                
                self.currentLocationText = placemark.thoroughfare
//                println(self.currentLocationText)
            }
        })
    }
    
}