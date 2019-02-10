//
//  OrdersVC.swift
//  nqosh
//
//  Created by Mac on 1/27/19.
//  Copyright © 2019 Hesham. All rights reserved.
//

import UIKit
import CoreData
import MapKit

class OrdersVC: UIViewController,UITableViewDelegate,UITableViewDataSource,OrdersProtocol {
    
    
    var context:NSManagedObjectContext?

    @IBOutlet weak var confirmButt: UIButton!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var data:[Order]?
    var total:Double = 0.0
    let locationManager = CLLocationManager()

    //var orderDetails =  [[Int]]()
    var orderDetails:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        context =
            appDelegate.persistentContainer.viewContext
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        locationManager.requestWhenInUseAuthorization()

        //2
        let fetchRequest =
            NSFetchRequest<Order>(entityName: "Order")
        //3
        do {
            data = try context?.fetch(fetchRequest) as? [Order]
            if data!.isEmpty {
                confirmButt.isHidden = true
                totalLabel.isHidden = true
            }
            self.tableView.reloadData()
            calculateTotal()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCellID") as! OrderCell
        let pos = indexPath.row
        cell.deleteButt.tag = pos
        cell.reduceButt.tag = pos
        cell.increaseButt.tag = pos

        cell.ordersProtocol = self
        if let order = self.data?[pos] {
            cell.productName.text = (order.name)
            cell.productPrice.text = "ريال" + order.price!
            cell.quantityLabel.text = "\(order.quantity)"
            let url = URL(string: order.image!)
            cell.orderImg.kf.setImage(with: url)
        }
        
        
        
        return cell
    }
    
   
    func didPressIncreaseButton(_ tag: Int, _ sender: UIButton) {
        let object = data![tag]
        object.quantity += 1
        self.tableView.reloadData()
        calculateTotal()
    }
    
    func didPressDecreaseButton(_ tag: Int, _ sender: UIButton) {
        let object = data![tag]
        if object.quantity >= 1 {
            object.quantity -= 1
            self.tableView.reloadData()
            calculateTotal()
        }
        
        
    }
    
    func didPressDeleteButton(_ tag: Int, _ sender: UIButton) {
        let object = data![tag]
        
        context?.delete(object)
        data?.remove(at: tag)
        self.tableView.reloadData()
        calculateTotal()
        
    }
    
    
    func calculateTotal(){
        total = 0.0
        //orderDetails.removeAll()
        
        let prodArray:NSMutableArray = NSMutableArray()

        for order in self.data!{
           // orderDetails.append([Int(order.id),Int(order.quantity)])
            total = total + (Double(order.quantity) * (order.price?.toDouble() ?? 0.0))
            
            let prod: NSMutableDictionary = NSMutableDictionary()
            prod.setValue(order.id, forKey: "id")
            prod.setValue(order.quantity, forKey: "quantity")
            prod.setValue(order.color, forKey: "color")
            prodArray.add(prod)
        }

        
        let jsonData: Data? = try? JSONSerialization.data(withJSONObject: prodArray)
        orderDetails = String(data: jsonData!, encoding: .utf8);
        
        self.totalLabel.text = "\(total) ريال"
    }
    
    
    @IBAction func confirm(_ sender: Any) {
    
        performSegue(withIdentifier: "confirmSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "confirmSegue"{
            let destination = segue.destination as! ConfirmVC
            destination.total = self.total
            destination.products = self.orderDetails!
        }
    }
    
}
