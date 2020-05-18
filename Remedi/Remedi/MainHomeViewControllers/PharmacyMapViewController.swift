//
//  PharmacyMapViewController.swift
//  Remedi
//
//  Created by Shanky(Prgm) on 10/31/19.
//  Copyright © 2019 Shashank Venkatramani. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import FirebaseDatabase
class PharmacyMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    var uid:String?
    var presentTransition: UIViewControllerAnimatedTransitioning?
    var dismissTransition: UIViewControllerAnimatedTransitioning?
    var locationManager = CLLocationManager()
    var ref:DatabaseReference = Database.database().reference()
    @IBOutlet var mapKit: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapKit.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.requestWhenInUseAuthorization()
        }
        
        let viewRegion = MKCoordinateRegion(center: locationManager.location!.coordinate, latitudinalMeters: 3000, longitudinalMeters: 3000)
        mapKit.setRegion(viewRegion, animated: false)
        DispatchQueue.main.async {
            self.locationManager.startUpdatingLocation()
        }
        addPharmacies()
    }
    
    func addPharmacies(){
        ref.child("pharmacy").observeSingleEvent(of: .value) { (snapshot) in
            let pharmacies = snapshot.value as! NSMutableDictionary
            for (key, value) in pharmacies{
                let pharmacy = value as! NSMutableDictionary
                let pharmacyPin = MKPointAnnotation()
                
                pharmacyPin.title = pharmacy.value(forKey: "name") as! String
                pharmacyPin.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(pharmacy.value(forKey: "latitude") as! NSNumber), longitude: CLLocationDegrees(pharmacy.value(forKey: "longitude") as! NSNumber))
                if(pharmacy.value(forKey: "score") as! Int > 7){
                    pharmacyPin.subtitle = "This pharmacy is historically safe"
                } else if (pharmacy.value(forKey: "score") as! Int > 4){
                    pharmacyPin.subtitle = "Be wary of medications at this establishment"
                } else {
                    pharmacyPin.subtitle = "We highly do not recommend this pharmacy due to it's history of counterfeit medicine"
                }
                self.mapKit.addAnnotation(pharmacyPin)
            }
        }
    }
    
    @IBAction func QRButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "QRCodeViewController") as! QRCodeViewController
        vc.uid = uid!
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "TrackerViewController") as! TrackerViewController
        vc.uid = uid!
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    @IBAction func TrackerButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "TrackerViewController") as! TrackerViewController
        vc.uid = uid!
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
    
}

extension PharmacyMapViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentTransition
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissTransition
    }
}
