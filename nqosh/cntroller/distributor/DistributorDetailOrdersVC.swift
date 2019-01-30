//
//  DistributorDetailOrdersVC.swift
//  nqosh
//
//  Created by Mac on 1/29/19.
//  Copyright © 2019 Hesham. All rights reserved.
//

import UIKit
import MapKit
class DistributorDetailOrdersVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var clientName: UILabel!
    @IBOutlet weak var clientPhone: UILabel!
    @IBOutlet weak var clientAddress: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    
    var orderModel:OrdersModel?
    var productdata = [productModel]()
    var quantity = [Int]()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"back.jpg")!)
        tableView.delegate = self
        tableView.dataSource = self
        clientName.text = orderModel?.client_name ?? ""
        clientAddress.text = orderModel?.plus ?? ""
        clientPhone.text = orderModel?.client_phone ?? ""
        totalLabel.text = "ريال \(orderModel?.total ?? "")"
        setdata()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCellID") as! DistributorDetailOrderCell
        let pos = indexPath.row
        
         let order = self.productdata[pos]
        
            cell.productName.text = order.name
            cell.productPrice.text =  order.price! + "ريال" 
            cell.quantity.text = "\(self.quantity[pos])"
            let url = URL(string: order.image!)
            cell.productImg.kf.setImage(with: url)
        
        
        return cell
    }
    
    @IBAction func start(_ sender: Any) {
        
        let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: self.orderModel?.latitude?.toDouble() ?? 0, longitude: self.orderModel?.longitude?.toDouble() ?? 0)))
        destination.name = self.orderModel?.plus!
        
        MKMapItem.openMaps(with: [destination], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
    
    @IBAction func done(_ sender: Any) {
        
        Api.finishOrder(id: self.orderModel?.id ?? 0) { (error:Error?, msg:String) in
            self.showAlert(message: msg)
        }
    }
    
    
    func setdata()  {
        let product = orderModel?.products
        for data in product! {
            
            quantity.append(data["quantity"].int!)
            if let data = data["product"].dictionary ,let info = productModel.init(dic: data) {
                productdata.append(info)
            }
        }
        
       self.tableView.reloadData()
    }
}
