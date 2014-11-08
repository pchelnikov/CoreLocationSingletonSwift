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
    var currentLocation = CLLocation()
    
//    class var shared : LocationManager {
//        struct Static {
//            static var onceToken : dispatch_once_t = 0
//            static var instance : LocationManager? = nil
//        }
//        dispatch_once(&Static.onceToken) {
//            Static.instance = LocationManager()
//        }
//        return Static.instance!
//    }
    
    override init() {
        super.init()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        } else {
            println("Location services are not enabled!")
        }
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
        var locationObj = locationArray.lastObject as CLLocation
        var coord = locationObj.coordinate
        
        println(coord.latitude)
        println(coord.longitude)
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
//        println(newLocation)
        currentLocation = newLocation
    }
    
}