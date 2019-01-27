//
//  ConfirmVC.swift
//  nqosh
//
//  Created by Mac on 1/26/19.
//  Copyright © 2019 Hesham. All rights reserved.
//

import UIKit
import MapKit
import GooglePlaces
import GooglePlacePicker
var placesClient: GMSPlacesClient!


class ConfirmVC: UIViewController, UINavigationControllerDelegate,GMSPlacePickerViewControllerDelegate {
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var clientNum: UITextField!
    @IBOutlet weak var clientAddress: UITextField!
    let locationManager = CLLocationManager()
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named:"back")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        placesClient = GMSPlacesClient.shared()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"back.jpg")!)

    }
    override func viewWillAppear(_ animated: Bool) {
        locationManager.requestAlwaysAuthorization()
        placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
            if let location = placeLikelihoodList?.likelihoods.last?.place{
                self.clientAddress.text = location.formattedAddress ?? ""
                self.updateLocationOnMap(place: location)
            }
            
        })
    }
    
    @IBAction func locationEdit(_ sender: Any) {
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        present(placePicker, animated: true, completion: nil)
    }
    
    @IBAction func sendOrder(_ sender: Any) {
    }
    
    

    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        updateLocationOnMap(place: place)
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        print("No place selected")
    }
    
    func updateLocationOnMap(place:GMSPlace){
        let center = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.map.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        self.map.addAnnotation(annotation)
    }
}
