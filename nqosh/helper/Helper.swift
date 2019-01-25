//
//  Helper.swift
//  Salonat
//
//  Created by salman on 10/28/18.
//  Copyright © 2018 salman. All rights reserved.
//

import UIKit

class Helper: NSObject {
    
    class func restartApp(){
        
        guard let window = UIApplication.shared.keyWindow else{return}
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var vc:UIViewController
        
        if islogedin() == true {
            vc = storyboard.instantiateViewController(withIdentifier: "Home")
        } else{
            vc = (storyboard.instantiateInitialViewController())!
        }
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
    }
    
    class func islogedin()->Bool{
        let def = UserDefaults.standard
        if !(def.object(forKey: "user_phone") != nil){
            return false
        }else{
            return true
        }
    }
    class func setUserData(user_id : Int,user_full_name:String,user_phone:String,user_address:String,country:String,city_title:String,email:String){
        let def = UserDefaults.standard
        def.setValue(user_id, forKey: "user_id")
        def.setValue(user_full_name, forKey: "user_full_name")
        def.setValue(user_phone, forKey: "user_phone")
        def.setValue(user_address, forKey: "user_address")
        def.setValue(country, forKey: "country")
        def.setValue(city_title, forKey: "city_title")
        def.setValue(email, forKey: "email")

        def.synchronize()
        restartApp()
    }
    
    class func getUserType()->String{
        let def = UserDefaults.standard
        return (def.object(forKey: "user_type") as? String)!//user_full_name
        
    }

    class func getUserData()->Bool{
        let def = UserDefaults.standard
        return (def.object(forKey: "user_email") as? String) != nil
        
    }
    class func getuserid()->Int{
        let def = UserDefaults.standard
        return (def.object(forKey: "user_id") as! Int)
    }
    class func getuserphone()->String{
        let def = UserDefaults.standard
        return (def.object(forKey: "user_phone") as! String)
    }
    class func getdata()->Dictionary<String,String>{
        let def = UserDefaults.standard
        
        let data:[String:String] = [
            
            "user_email":def.object(forKey: "user_email") as!String ,
            "user_name":def.object(forKey: "user_name")as!String,
            "user_photo":def.object(forKey: "user_photo") as!String,
            ]
        
        return data
    }
    class func logout(){
        let def = UserDefaults.standard
        def.removeObject(forKey: "user_phone")
        restartApp()
        
    }
}
