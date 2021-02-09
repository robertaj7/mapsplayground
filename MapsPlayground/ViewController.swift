//
//  ViewController.swift
//  MapsPlayground
//
//  Created by Roberta Jorgo on 3.2.21.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        manager.desiredAccuracy = kCLLocationAccuracyReduced // Affects battery life
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        getAnnotations()
    }
    
    func getAnnotations() {
        var placemarks = Placemark.mock()
        for placemark in placemarks {
            self.mapView.addAnnotation(
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation()
            let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let _ = MKCoordinateRegion(center: coordinate, span: span)
            //LiveMap.setRegion(region, animated: true)
            self.mapView.showsUserLocation = true
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customannotation")
        annotationView.image = UIImage(named: "marker")
        annotationView.canShowCallout = true
        
        let button = UIButton(type: UIButton.ButtonType.detailDisclosure) as UIButton // button with info sign in it
        annotationView.rightCalloutAccessoryView = button
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("annotation title == \(String(describing: view.annotation?.title!))")
        if let annotationTitle = view.annotation?.title
        {
            print("USER TAPPED ON ANNOTATION WITH TITLE: \(annotationTitle!)")
            //Open secondViewController
            //present(secondViewController(), animated: true)
        }
        
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

