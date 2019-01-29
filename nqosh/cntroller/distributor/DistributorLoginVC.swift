//
//  DistributorLoginVC.swift
//  nqosh
//
//  Created by Mac on 1/29/19.
//  Copyright © 2019 Hesham. All rights reserved.
//

import UIKit

class DistributorLoginVC: UIViewController {

    //distributionOrderDetail
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"back.jpg")!)
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if defaults.bool(forKey: "isLogin"){
            self.performSegue(withIdentifier: "destribtuionsOrdersSegue", sender: nil)
        }
    }

    @IBAction func login(_ sender: Any) {
        
        let phone = self.userName.text!
        let pass = self.password.text!
        
        if phone.isEmpty || pass.isEmpty{
            self.showAlert(message: "جميع الحقول مطلوبة")
        }else{
            Api.login(client_phone: phone, client_pass: pass) { (error:Error?, success:Bool) in
                if success{
                    self.defaults.set(true, forKey: "isLogin")
                    self.performSegue(withIdentifier: "destribtuionsOrdersSegue", sender: nil)
                }else{
                    self.showAlert(message: "خطأ في الدخول لشاشة الموزع")

                }
            }
        }
    }
    

}
