//
//  ProductDetail.swift
//  nqosh
//
//  Created by Mac on 1/26/19.
//  Copyright © 2019 Hesham. All rights reserved.
//

import UIKit
import CoreData
import SelectionList

class ProductDetail: UIViewController {

    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDesc: UILabel!
    
    @IBOutlet weak var selectionList: SelectionList!
    
    @IBOutlet weak var totalIndicator: UILabel!
    @IBOutlet weak var countIndicator: UILabel!
    
    var productdata : productModel?
    
    var total :Double = 0.0
    var count : Int = 1
    var avalible : Int = 0
    var price : Double = 0.0
    var colors = [String]()
    
    var context:NSManagedObjectContext?
    var entity:NSEntityDescription?
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        entity = NSEntityDescription.entity(forEntityName: "Order", in: context!)
        
        if productdata != nil{
            productName.text = productdata?.name
            productDesc.text = productdata?.detailes
            total = productdata!.price?.toDouble() ?? 0.0
            price = total
            let url = URL(string: productdata?.image! ?? "")
            productImg.kf.setImage(with: url)
            avalible = Int(productdata?.quantity ?? "0")!
            //productCount.text = "العدد المتوفر : \(avalible) "
            totalIndicator.text = "\(total) ريال"
            

            selectionList.items = []
            selectionList.allowsMultipleSelection = false
            selectionList.selectedIndex = 0

            selectionList.addTarget(self, action: #selector(selectionChanged), for: .valueChanged)
            selectionList.setupCell = { (cell: UITableViewCell, _: Int) in
                cell.textLabel?.textColor = .gray
            }
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
        if count > 1 {
            count -= 1
            total = Double(count) * price
            totalIndicator.text = "\(total) ريال"
            countIndicator.text = "\(count)"
        }
    }
    
    @IBAction func addToBasket(_ sender: Any) {
        
        let newOrder = NSManagedObject(entity: entity!, insertInto: context)
        
        newOrder.setValue(productdata!.id, forKey: "id")
        newOrder.setValue(productdata!.name, forKey: "name")
        newOrder.setValue(productdata!.image, forKey: "image")
        newOrder.setValue(count, forKey: "quantity")
        newOrder.setValue(colors[selectionList.selectedIndex ?? 0], forKey: "color")
        newOrder.setValue(productdata!.price, forKey: "price")

        do {
            
            try context?.save()
            navigationController?.popViewController(animated: true)

        } catch {
            
            print("Failed saving")
        }
    }
    
    
    @objc func selectionChanged() {
       
    }
}
