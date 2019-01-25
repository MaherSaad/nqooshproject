
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
    
 
    
    
    
    
    
    
    
    
}
