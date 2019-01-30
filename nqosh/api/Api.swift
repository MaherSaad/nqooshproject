
import UIKit
import Alamofire
import SwiftyJSON
class Api: NSObject {
    class var isconnectedtotheinternet:Bool{
        return NetworkReachabilityManager()!.isReachable
    }
    ///////caterios
    class func categories(completion:@escaping(_ error :Error? ,_ data:[catModel]?)->Void){
        let BaseUrl = config.category
        Alamofire.request(BaseUrl)
            .validate(statusCode:200..<300)
            .responseJSON { response in
                switch response.result
                {
                case .failure( let error):
                    print(error)
                    completion(error , nil)
                case .success(let value):
                    let json = JSON(value)
                    // print(json)
                    let datobj = json
                    
                    guard let dataArr = datobj["data"].array else{
                        completion(nil , nil)
                        return
                    }
                    var results = [catModel]()
                    for data in dataArr {
                        
                        if let data = data.dictionary ,let info = catModel.init(dic: data) {
                            results.append(info)
                        }
                    }
                    completion(nil,results)
                }
                
        }
        
    }
    
    ///////services
    class func services(completion:@escaping(_ error :Error? ,_ data:[ServicesModel]?)->Void){
        let BaseUrl = config.services
        Alamofire.request(BaseUrl)
            .validate(statusCode:200..<300)
            .responseJSON { response in
                switch response.result
                {
                case .failure( let error):
                    print(error)
                    completion(error , nil)
                case .success(let value):
                    let json = JSON(value)
                    // print(json)
                    let datobj = json
                    
                    guard let dataArr = datobj["data"].array else{
                        completion(nil , nil)
                        return
                    }
                    var results = [ServicesModel]()
                    for data in dataArr {
                        if let data = data.dictionary ,let info = ServicesModel.init(dic: data) {
                            results.append(info)
                        }
                    }
                    completion(nil,results)
                }
                
        }
        
    }
    //////order services
    class func orderService(client_phone:String,client_name:String,details:String,service_id:Int, completion:@escaping(_ error :Error? ,_ msg:String)->Void){
        let BaseUrl = config.serviceorders
        
        
        
        let parameters:Parameters = ["client_phone":client_phone,"client_name":client_name,"details":details,"service_id":service_id]
        
        Alamofire.request(BaseUrl, method: .post, parameters: parameters)
            .validate(statusCode:200..<300)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure( let error):
                    print(error)
                    completion(error , "")
                case .success(let value):
                    print(value)
                    let json = JSON(value)
                    if let msg = json["message"].string{
                        
                        completion(nil, msg)
                        
                    }else{
                        completion(nil,"")
                    }
                    // print(json)
                }
        }
    }
    
    //////order products
    class func order(client_phone:String,client_name:String,products:String,total:Double,longitude:Double, latitude:Double,plus:String,completion:@escaping(_ error :Error? ,_ msg:String)->Void){
        let BaseUrl = config.orders
        
        let parameters:Parameters = ["client_phone":client_phone,"client_name":client_name,"delivery_price":0,"delivery":0,"products":products,"total":total,"longitude":longitude,"latitude":latitude,"status":0,"plus":plus]

            print(parameters)
        
        Alamofire.request(BaseUrl, method: .post, parameters: parameters)
            .validate(statusCode:200..<300)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure( let error):
                    print(error)
                    completion(error , "")
                case .success(let value):
                    let json = JSON(value)
                    if let msg = json["message"].string{
                        completion(nil, msg)
    
                    }else{
                        completion(nil,"")
                    }
                    // print(json)
                }
        }
    }
    
    //////distributor login
    class func login(phone:String,pass:String,completion:@escaping(_ error :Error? ,_ success:Bool)->Void){
        let BaseUrl = config.login
        
        //,"username":username
        let parameters:Parameters = ["phone":phone,"password":pass]
        
        
        Alamofire.request(BaseUrl, method: .post, parameters: parameters)
            .validate(statusCode:200..<300)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure( let error):
                    completion(error , false)
                case .success(let value):
                    let json = JSON(value)
                    if let msg = json["message"].string{
                        if msg == "Success"{
                            completion(nil, true)
                        }else{
                            completion(nil, false)
                        }
                        
                    }else{
                        completion(nil,false)
                    }
                    // print(json)
                }
        }
    }
    
    
    
    
    ///////getOrders
    class func getOrders(completion:@escaping(_ error :Error? ,_ data:[OrdersModel]?)->Void){
        let BaseUrl = config.orders
        Alamofire.request(BaseUrl)
            .validate(statusCode:200..<300)
            .responseJSON { response in
                switch response.result
                {
                case .failure( let error):
                    print(error)
                    completion(error , nil)
                case .success(let value):
                    let json = JSON(value)
                    // print(json)
                    let datobj = json
                    
                    guard let dataArr = datobj["data"].array else{
                        completion(nil , nil)
                        return
                    }
                    var results = [OrdersModel]()
                    for data in dataArr {
                        
                        if let data = data.dictionary ,let info = OrdersModel.init(dic: data) {
                            results.append(info)
                        }
                    }
                    completion(nil,results)
                }
                
        }
        
    }
    
    
    //////finish order
    class func finishOrder(id:Int,completion:@escaping(_ error :Error? ,_ msg:String)->Void){
        let BaseUrl = config.updateStatus + "\(id)"
        
        let parameters:Parameters = ["status":1]
        
        Alamofire.request(BaseUrl, method: .post, parameters: parameters)
            .validate(statusCode:200..<300)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure( let error):
                    print(error)
                    completion(error , "خطأ في الاتصال")
                case .success(let value):
                    completion(nil, "تم توصيل الاوردر")
                }
        }
    }
    
    
}
