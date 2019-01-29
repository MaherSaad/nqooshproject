//
//  DistributorDetailOrdersVC.swift
//  nqosh
//
//  Created by Mac on 1/29/19.
//  Copyright © 2019 Hesham. All rights reserved.
//

import UIKit

class DistributorDetailOrdersVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var clientName: UILabel!
    @IBOutlet weak var clientPhone: UILabel!
    @IBOutlet weak var clientAddress: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"back.jpg")!)

    }

    
    @IBAction func start(_ sender: Any) {
    }
    
    @IBAction func done(_ sender: Any) {
    }
}
