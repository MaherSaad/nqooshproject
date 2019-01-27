//
//  ServicesOrderVC.swift
//  nqosh
//
//  Created by Mac on 1/27/19.
//  Copyright © 2019 Hesham. All rights reserved.
//

import UIKit

class ServicesOrderVC: UIViewController {
    @IBOutlet weak var client_name: UITextField!

    @IBOutlet weak var client_phone: UITextField!
    @IBOutlet weak var details: UITextView!
    
    var serviceId:Int?
    var serviceName:String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"back.jpg")!)

        details.text = serviceName!
    }
    

    @IBAction func order(_ sender: Any) {
        let name = client_name.text!
        let phone = client_phone.text!
        let detail = details.text!
        
        if name.isEmpty || phone.isEmpty || detail.isEmpty{
            self.showAlert(message: "جميع الحقول مطلوبة")
        }else{
            Api.orderService(client_phone: phone, client_name: name, details: detail, service_id: self.serviceId!) { (error:Error?, msg:String) in
                var message = msg
                if message.isEmpty {
                    message = "خطأ في طلب الخدمة"
                }
                self.showAlert(message: message)
            }
        }
    }
    

}
