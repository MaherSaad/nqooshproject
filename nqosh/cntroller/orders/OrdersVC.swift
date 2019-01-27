//
//  OrdersVC.swift
//  nqosh
//
//  Created by Mac on 1/27/19.
//  Copyright © 2019 Hesham. All rights reserved.
//

import UIKit

class OrdersVC: UIViewController,UITableViewDelegate,UITableViewDataSource,OrdersProtocol {
    
    
  

    @IBOutlet weak var confirmButt: UIButton!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCellID") as! OrderCell
        let pos = indexPath.row
        cell.increaseButt.tag = pos
        cell.deleteButt.tag = pos
        cell.reduceButt.tag = pos
        cell.ordersProtocol = self
        return cell
    }
    
   
    func didPressIncreaseButton(_ tag: Int, _ sender: UIButton) {
        
    }
    
    func didPressDecreaseButton(_ tag: Int, _ sender: UIButton) {
        
    }
    
    func didPressDeleteButton(_ tag: Int, _ sender: UIButton) {
        
    }
}
