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
import CoreData
var placesClient: GMSPlacesClient!


class ConfirmVC: UIViewController, UINavigationControllerDelegate,GMSPlacePickerViewControllerDelegate {
    
    @IBOutlet weak var clientName: UITextField!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var clientNum: UITextField!
    @IBOutlet weak var clientAddress: UITextField!
    let locationManager = CLLocationManager()
    var lng:Double = 0.0
    var lat:Double = 0.0
    
    var total:Double?
    var products:[[Int]]?
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        placesClient = GMSPlacesClient.shared()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"back.jpg")!)
        locationManager.requestAlwaysAuthorization()
        placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
            if let location = placeLikelihoodList?.likelihoods.last?.place{
                
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
        let name = self.clientName.text!
        let phone = self.clientNum.text!
        let address = self.clientAddress.text!
    
        if name.isEmpty || phone.isEmpty || address.isEmpty{
            self.showAlert(message: "جميع الحقول مطلوبة")
        }else{
            Api.order(client_phone: phone, client_name: name, products: "\(self.products!)", total: self.total!, longitude: self.lng, latitude: self.lat,plus: address) { (error:Error?, msg:String) in
                var message = msg
                if message.isEmpty {
                    message = "خطأ في طلب الخدمة"
                }
                self.showAlert(message: message)
               
                if message == "Success"{
                    guard let appDelegate =
                        UIApplication.shared.delegate as? AppDelegate else {return}
                    let context =
                        appDelegate.persistentContainer.viewContext
                    let fetchRequest =
                        NSFetchRequest<NSFetchRequestResult>(entityName: "Order")
                    let request = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                    do {
                        try context.execute(request)
                    }catch {
                        print("Failed to delete all")
                    }

                }
                
                }
            

        }
        
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
        lat = place.coordinate.latitude
        lng = place.coordinate.longitude
        self.clientAddress.text = place.formattedAddress ?? ""
        let center = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.map.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        self.map.addAnnotation(annotation)
    }
}
