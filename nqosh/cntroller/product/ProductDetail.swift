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
import SwiftyJSON

class ProductDetail: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDesc: UILabel!
    @IBOutlet weak var colorCollection: UICollectionView!
    
    
    @IBOutlet weak var totalIndicator: UILabel!
    @IBOutlet weak var countIndicator: UILabel!
    
    var productdata : productModel?
    var selectedColor = 0
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
            for color in productdata!.colors {
                colors.append(color.string!)
            }
            productName.text = productdata?.name
            productDesc.text = productdata?.detailes
            total = productdata!.price?.toDouble() ?? 0.0
            price = total
            let url = URL(string: productdata?.image! ?? "")
            productImg.kf.setImage(with: url)
            avalible = Int(productdata?.quantity ?? "0")!
            //productCount.text = "العدد المتوفر : \(avalible) "
            totalIndicator.text = "\(total) ريال"
            
            colorCollection.delegate = self
            colorCollection.dataSource = self
        
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
        newOrder.setValue(colors[selectedColor] ?? "", forKey: "color")
        newOrder.setValue(productdata!.price, forKey: "price")

        do {
            
            try context?.save()
            navigationController?.popViewController(animated: true)

        } catch {
            
            print("Failed saving")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedColor = indexPath.row
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCellID", for: indexPath)
        
        cell.backgroundColor = hexStringToUIColor(hex: colors[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
