//
//  OrderCell.swift
//  nqosh
//
//  Created by Mac on 1/27/19.
//  Copyright © 2019 Hesham. All rights reserved.
//

import UIKit

class OrderCell: UITableViewCell {

    @IBOutlet weak var orderImg: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var deleteButt: UIButton!
    @IBOutlet weak var reduceButt: UIButton!
    @IBOutlet weak var increaseButt: UIButton!
    weak var ordersProtocol:OrdersProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func removeOrder(_ sender: UIButton) {
        ordersProtocol?.didPressDeleteButton(sender.tag, sender)
    }
    
    @IBAction func reduce(_ sender: UIButton) {
        ordersProtocol?.didPressDecreaseButton(sender.tag, sender)
    }
    
    @IBAction func increase(_ sender: UIButton) {
        ordersProtocol?.didPressIncreaseButton(sender.tag, sender)
    }
    
}
