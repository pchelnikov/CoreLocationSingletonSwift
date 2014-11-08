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
        
        let buttonGetLocation = UIButton.buttonWithType(.System) as UIButton
        
        buttonGetLocation.titleLabel?.font = UIFont.systemFontOfSize(17)
        buttonGetLocation.setTitle("Current Location", forState: .Normal)
        buttonGetLocation.addTarget(self, action: "getCurrentLocation:", forControlEvents: .TouchUpInside)
        buttonGetLocation.setTitleColor(UIColor.blueColor(), forState: .Normal)
        
        view.addSubview(buttonGetLocation)
        
        buttonGetLocation.frame = CGRectMake(30,100,150,20)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let locationManager = LocationManager.shared
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getCurrentLocation(sender: UIButton) {
        let locationManager = LocationManager.shared
        println(locationManager.currentLocationText)
    }
    
}