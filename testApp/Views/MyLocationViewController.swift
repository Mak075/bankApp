import UIKit
import MapKit
import CoreLocation

class MyLocationViewController: UIViewController, CLLocationManagerDelegate {
    
    private let manager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}
    
