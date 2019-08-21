//
//  EventDetailController.swift
//  MC3 Volunteering
//
//  Created by Silamitra Edvyn Tanu on 21/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit
import MapKit

class customPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    
    init(pinTitle: String, pinSubTitle: String, location:CLLocationCoordinate2D) {
        self.title = pinTitle
        self.subtitle = pinSubTitle
        self.coordinate = location
    }
}

class EventDetailController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var imageEventDetailed: UIImageView!
    
    
    var imageContainer: UIImage?
    
    @IBOutlet var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageEventDetailed.image = imageContainer
        
        let location = CLLocationCoordinate2D(latitude: -6.175392, longitude: 106.827153)
        //itu lattitude sama longitude monas, kaya buat default aja
        let region = MKCoordinateRegion (center: location , span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        self.mapView.setRegion(region, animated: true)
        let pin = customPin(pinTitle: "monas", pinSubTitle: "jakarta", location: location)
        self.mapView.addAnnotation(pin)
        self.mapView.delegate = self
        
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation {
                return nil
            }
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customannotation")
            annotationView.image = UIImage(named: "pin")
            annotationView.canShowCallout = true
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            print("annotation title == \(String(describing:view.annotation?.title!))")
        }
        
    }
}
