//
//  ProductDetail.swift
//  nqosh
//
//  Created by Mac on 1/26/19.
//  Copyright © 2019 Hesham. All rights reserved.
//

import UIKit

class ProductDetail: UIViewController {

    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDesc: UILabel!
    @IBOutlet weak var productCount: UILabel!
    @IBOutlet weak var totalIndicator: UILabel!
    @IBOutlet weak var countIndicator: UILabel!
    
    var productdata : productModel?
    
    var total :Double = 0.0
    var count : Int = 1
    var avalible : Int = 0
    var price : Double = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()

        if productdata != nil{
            productName.text = productdata?.name
            productDesc.text = productdata?.detailes
            total = productdata!.price?.toDouble() ?? 0.0
            price = total
            let url = URL(string: productdata?.image! ?? "")
            productImg.kf.setImage(with: url)
            avalible = Int(productdata?.quantity ?? "0")!
            productCount.text = "العدد المتوفر : \(avalible) "
            totalIndicator.text = "\(total) ريال"
            
        }else{
            navigationController?.popViewController(animated: true)
        }
        
    }
    

    @IBAction func add(_ sender: Any) {
        if count <= avalible {
            count += 1
            total = Double(count) * price
            totalIndicator.text = "\(total) ريال"
            countIndicator.text = "\(count)"
        }
    }
    
    
    @IBAction func remove(_ sender: Any) {
        if count >= 1 {
            count -= 1
            total = Double(count) * price
            totalIndicator.text = "\(total) ريال"
            countIndicator.text = "\(count)"
        }
    }
    
    @IBAction func addToBasket(_ sender: Any) {
    }
}
