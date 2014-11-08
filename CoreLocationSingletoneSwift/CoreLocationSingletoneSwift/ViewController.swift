//
//  ViewController.swift
//  CoreLocationSingletoneSwift
//
//  Created by Mikhail Pchelnikov on 08/11/14.
//  Copyright (c) 2014 Mikhail Pchelnikov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        
        let locationManager = LocationManager.shared
        
        locationManager.startUpdatingLocation()
        println(locationManager.currentLocation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}