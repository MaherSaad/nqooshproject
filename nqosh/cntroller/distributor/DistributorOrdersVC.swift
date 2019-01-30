//
//  DistributorOrdersVC.swift
//  nqosh
//
//  Created by Mac on 1/29/19.
//  Copyright © 2019 Hesham. All rights reserved.
//

import UIKit

class DistributorOrdersVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"back.jpg")!)

       
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCellID") as! OrderCell
        let pos = indexPath.row
        cell.deleteButt.tag = pos
        cell.reduceButt.tag = pos
        cell.increaseButt.tag = pos
        
        cell.ordersProtocol = self
        if let order = self.data?[pos] {
            cell.productName.text = order.name
            cell.productPrice.text = "ريال" + order.price!
            cell.quantityLabel.text = "\(order.quantity)"
            let url = URL(string: order.image!)
            cell.orderImg.kf.setImage(with: url)
        }
        
        
        
        return cell
    }


    

}
