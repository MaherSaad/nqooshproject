//
//  OrdersProtocol.swift
//  nqosh
//
//  Created by Mac on 1/27/19.
//  Copyright © 2019 Hesham. All rights reserved.
//

import Foundation
import UIKit

protocol OrdersProtocol:class {
    
    func didPressIncreaseButton(_ tag: Int,_ sender: UIButton)
    func didPressDecreaseButton(_ tag: Int,_ sender: UIButton)
    func didPressDeleteButton(_ tag: Int,_ sender: UIButton)
}

