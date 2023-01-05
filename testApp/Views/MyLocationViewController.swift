import UIKit
import MapKit

class MyLocationViewController: UIViewController {
    
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocationCoordinate2D?

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLocationServices()
    }
    
    
    
    private func configureLocationServices() {
        
        locationManager.delegate = self
        
        let status = CLLocationManager.authorizationStatus()
        
        if status == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else if status == .authorizedAlways || status == .authorizedWhenInUse {
            beginLocationUpdates(locationManager: locationManager)
        }
        
    }
    
    private func beginLocationUpdates(locationManager: CLLocationManager) {
        
        mapView.showsUserLocation = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
    }
    
    private func zoomToLatestLocation (with coordinate: CLLocationCoordinate2D) {
        
        let zoomRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 10000)
        mapView.setRegion(zoomRegion, animated: true)
        
    }
    
}





extension MyLocationViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let latestLocation = locations.first else { return }
        
        if currentLocation == nil { zoomToLatestLocation(with: latestLocation.coordinate) }
        
        currentLocation = latestLocation.coordinate
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            
            beginLocationUpdates(locationManager: manager)
            
        }
        
    }
}


