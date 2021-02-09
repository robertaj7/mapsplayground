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
    
    @IBAction func linkMinistriesButtonTapped(_ sender: Any) {
        showRouteOnMap(pickupCoordinate: CLLocationCoordinate2D(latitude: 41.3300837, longitude: 19.8297348), destinationCoordinate: CLLocationCoordinate2D(latitude: 41.3325816, longitude: 19.8146956))
    }
    
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        manager.desiredAccuracy = kCLLocationAccuracyReduced // Affects battery life
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        mapView.delegate = self
        
        getAnnotations()
    }
    
    func getAnnotations() {
        let placemarks = Placemark.mock()
        for placemark in placemarks {
            
            let annotation = MKPointAnnotation()
            annotation.title = placemark.name
  
            
            let location = CLLocationCoordinate2D(latitude: placemark.latitude, longitude: placemark.longitude)
            annotation.coordinate = location
            self.mapView.addAnnotation(annotation)
        }
        
        self.mapView.showAnnotations(mapView.annotations, animated: true)
    }
    
    
    /// show route step 1
    func showRouteOnMap(pickupCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {

            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: MKPlacemark(coordinate: pickupCoordinate, addressDictionary: nil))
            request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil))
        
            request.requestsAlternateRoutes = true
            request.transportType = .automobile

            let directions = MKDirections(request: request)

            directions.calculate { [unowned self] response, error in
                guard let unwrappedResponse = response else { return }
                
                //for getting just one route
                if let route = unwrappedResponse.routes.first {
                    //show on map
                    self.mapView.addOverlay(route.polyline)
                    //set the map area to show the route
                    self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets.init(top: 80.0, left: 20.0, bottom: 100.0, right: 20.0), animated: true)
                }
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

        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "annotation")
        annotationView.image = UIImage(named: "marker")
        annotationView.canShowCallout = true

        let button = UIButton(type: UIButton.ButtonType.detailDisclosure) as UIButton
        annotationView.rightCalloutAccessoryView = button

        return annotationView
    }
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        if annotation is MKUserLocation { return nil }
//
//        if #available(iOS 11.0, *) {
//            if annotation is MKClusterAnnotation { return nil }
//        }
//
//        let customAnnotationViewIdentifier = "MyAnnotation"
//
//        var pin = mapView.dequeueReusableAnnotationView(withIdentifier: customAnnotationViewIdentifier)
//        if pin == nil {
//            pin = CustomAnnotationView(annotation: annotation, reuseIdentifier: customAnnotationViewIdentifier)
//        } else {
//            pin?.annotation = annotation
//        }
//        return pin
//    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        self.performSegue(withIdentifier: "showMarkerDetail", sender: self)
    }
    
    /// show route step 2
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
             renderer.strokeColor = UIColor.red
             renderer.lineWidth = 5.0
             return renderer
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == " " {
            segue.destination.modalPresentationStyle = .fullScreen
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

