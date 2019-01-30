//
//  DistributorOrdersVC.swift
//  nqosh
//
//  Created by Mac on 1/29/19.
//  Copyright © 2019 Hesham. All rights reserved.
//

import UIKit

class DistributorOrdersVC: UITableViewController {
    var dataArr = [OrdersModel]()
    @IBOutlet var pTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"back.jpg")!)
        
        getOrders()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrdersIdentifier") as! DistributorOrdersCell
        let item = dataArr[indexPath.row]
        cell.clientName.text = item.client_name!
        cell.clientPhone.text = item.client_phone!
        cell.clientAddress.text = item.plus!
        cell.total.text = item.total! + "ريال" 
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "distributionOrderDetail", sender: indexPath.row)
    }


    func getOrders(){
        Api.getOrders { (error:Error?, data:[OrdersModel]?) in
            self.dataArr = data!
            self.tableView.reloadData()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "distributionOrderDetail"{
            let destination = segue.destination as! DistributorDetailOrdersVC
            destination.orderModel = self.dataArr[(sender as! Int)]
        }
        
    }

}
