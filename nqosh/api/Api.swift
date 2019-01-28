
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
    class func order(client_phone:String,client_name:String,products:[[Int]],total:Double,longitude:Double, latitude:Double,plus:String,completion:@escaping(_ error :Error? ,_ msg:String)->Void){
        let BaseUrl = config.orders
        
        let parameters:Parameters = ["client_phone":client_phone,"client_name":client_name,"delivery_price":0,"delivery":0,"products[]":products,"total":total,"longitude":longitude,"latitude":latitude,"status":0,"plus":plus]

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
    
 
    
    
    
    
    
    
    
    
}
