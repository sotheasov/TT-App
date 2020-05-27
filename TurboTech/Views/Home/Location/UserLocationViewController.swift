//
//  UserLocationViewController.swift
//  TurboTech
//
//  Created by sq on 5/27/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps

class UserLocationViewController: UIViewController {
    
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation?
    var mapView: GMSMapView!
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 16.5
    
    let defaultLocation = CLLocation(latitude: 11.620456, longitude: 104.891839)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self

        placesClient = GMSPlacesClient.shared()
        
        locationManager.requestAlwaysAuthorization()
        
        let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude, longitude: defaultLocation.coordinate.longitude, zoom: zoomLevel)
        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true
        mapView.settings.myLocationButton = true
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.isMyLocationEnabled = true

        // Add the map to the view, hide it until we've got a location update.
        view.addSubview(mapView)
        mapView.isHidden = true
    }

}


// Delegates to handle events for the location manager.
extension UserLocationViewController: CLLocationManagerDelegate {
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")

        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: zoomLevel)
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
        }
    }

  // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
            case .restricted:
                print("Location access was restricted.")
                fallthrough
                case .denied:
                print("User denied access to location.")
                // Display the map using the default location.
                let alertController = UIAlertController(title: "Enable Location Service", message: "Please go to Settings and turn on Location permissions", preferredStyle: .alert)
                let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                        return
                    }
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
                    }
                }
          
                let cancelAction = UIAlertAction(title: "Cancel", style: .destructive){(action) in self.showAndDismissAlert(title: "Cannot Get Current Location", message: "Please go to setting and enable it.", style: .alert, second: 2)}
                alertController.addAction(cancelAction)
                alertController.addAction(settingsAction)

                // check the permission status
                switch(CLLocationManager.authorizationStatus()) {
                    case .authorizedAlways, .authorizedWhenInUse:
                        print("Authorize.")
                    //  get the user location
                    case .notDetermined, .restricted, .denied:
                    //  redirect the users to settings
                        self.present(alertController, animated: true, completion: nil)
                    default :
                        print("Default")
                }
                mapView.isHidden = false
            case .notDetermined:
                print("Location status not determined.")
            case .authorizedAlways: fallthrough
            case .authorizedWhenInUse:
                print("Location status is OK.")
            @unknown default:
                fatalError()
        }
    }

  // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}
