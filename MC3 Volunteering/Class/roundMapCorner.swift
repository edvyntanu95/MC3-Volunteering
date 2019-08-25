//
//  roundMapCorner.swift
//  MC3 Volunteering
//
//  Created by Silamitra Edvyn Tanu on 25/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class roundMapCorner: MKMapView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
        
    }
    
}
