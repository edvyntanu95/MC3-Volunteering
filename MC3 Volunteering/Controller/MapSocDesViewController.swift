//
//  MapSocDesViewController.swift
//  CustomAnnotationPin
//
//  Created by Benjamin Purbowasito on 02/09/19.
//  Copyright © 2019 iosda. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class titikPin: NSObject, MKAnnotation {
    
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(pinTitle: String, pinSubTitle: String, location:CLLocationCoordinate2D) {
        self.title = pinTitle
        self.subtitle = pinSubTitle
        self.coordinate = location
    }
    
    func getTitleName() -> String {
        return self.title!
    }
    
    func getSubTitleName() -> String {
        return self.subtitle!
    }
}

class MapSocDesViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    
    @IBAction func navBtn(_ sender: Any) {
        
        let lattitude: CLLocationDegrees = -6.256432
        let longitude: CLLocationDegrees = 106.618333
        
        let regionDistance: CLLocationDistance = 1000;
        let coordinates = CLLocationCoordinate2DMake(lattitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        
        let placemark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Social Designee"
        mapItem.openInMaps(launchOptions: options)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //map permission
        let location = CLLocationCoordinate2D(latitude: -6.256389, longitude: 106.618383)
        //itu lattitude sama longitude monas, kaya buat default aja
        let region = MKCoordinateRegion (center: location , span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        self.mapView.setRegion(region, animated: true)
        let pin = titikPin(pinTitle: "Social Designee", pinSubTitle: "", location: location)
        //locationAdress.text = "\(pin.getTitleName()) , \(pin.getSubTitleName())"
        
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

