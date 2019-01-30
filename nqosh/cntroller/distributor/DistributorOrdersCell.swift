//
//  DistributorOrdersCell.swift
//  nqosh
//
//  Created by Mac on 1/29/19.
//  Copyright © 2019 Hesham. All rights reserved.
//

import UIKit

class DistributorOrdersCell: UITableViewCell {
    @IBOutlet weak var clientName: UILabel!
    @IBOutlet weak var clientPhone: UILabel!
    
    @IBOutlet weak var clientAddress: UILabel!
    
    @IBOutlet weak var total: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
