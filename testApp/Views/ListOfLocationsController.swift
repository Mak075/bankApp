import Foundation

import UIKit
import MapKit
import CoreLocation

class MyPointAnnotationView: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    var title: String? = ""
    var subtitle: String? = ""
    var type: String?
    
}

class ListOfLocationsController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locations: [Location]?
    var dataManager = DataManager()
    private let manager = CLLocationManager()
    var pin: AnnotationPin?
    
    override func viewDidLoad() {

        super.viewDidLoad()
        dataManager.delegate = self
        dataManager.fetchData()
        addCostumPins()
        mapView.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {

        super.viewDidAppear(animated)
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let coordinates: CLLocationCoordinate2D = manager.location!.coordinate
        let spanDegree = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: coordinates, span: spanDegree)
        
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        
    }
    
    
    
    func addCostumPins() {
        
        for location in self.locations ?? [] {
            
            let pin = MyPointAnnotationView()
            let coordinates = CLLocationCoordinate2D(latitude: location.coordinates?.locationLat ?? 0, longitude: location.coordinates?.locationLong ?? 0)
            
            pin.coordinate = coordinates
            pin.title = location.name
            pin.subtitle = location.address
            pin.type = location.type
            mapView.addAnnotation(pin)
            
        }
    }
    
    
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {

        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "icon")

        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "icon")
            annotationView?.canShowCallout = true
        }   else {
            annotationView?.annotation = annotation
        }
        
        
        
        if let annotation = (annotation as? MyPointAnnotationView) {
            
            if annotation.type == "atm" {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "AtmViewController") as! AtmViewController
                
                for obj in self.locations ?? [] {
                    if(obj.name == annotation.title && obj.type == annotation.type) {
                        vc.atm = obj
                        self.present(vc, animated: true, completion: nil)
                    }
                }
                
            } else {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "BranchViewController") as! BranchViewController
                                
                for obj in self.locations ?? [] {
                    if(obj.name == annotation.title && obj.type == annotation.type) {
                        vc.branch = obj
                        self.present(vc, animated: true, completion: nil)
                    }
                }
                
            }
            
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }

        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "icon")

        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "icon")
            annotationView?.canShowCallout = true
        }   else {
            annotationView?.annotation = annotation
        }
        
        
        if let annotationType = (annotation as? MyPointAnnotationView)?.type {
            if annotationType == "atm" {
                annotationView?.image = UIImage(named: "ic_pin_atm")
            } else {
                annotationView?.image = UIImage(named: "ic_pin_branch")
            }
        }
        
        let transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        annotationView!.transform = transform
        
        return annotationView
    }
    

}
       
       
       
       extension ListOfLocationsController: DataManagerDelegate {
           func storeLocations(_ dataManager: DataManager, locations: [Location]) {
               DispatchQueue.main.async {
                   self.locations = locations
                   self.addCostumPins()
               }
           }
           
           func didFailWithError(error: Error) {
               print(error)
           }
       }

 
