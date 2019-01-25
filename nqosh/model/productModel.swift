import SwiftyJSON

public class productModel:NSObject {
    let id : Int?
    let name : String?
    let image : String?
    var price : String?
    var detailes : String?
    var quantity : String?
    var colors : [JSON]
    init?(dic:[String:JSON]) {
        guard let id = dic["id"]?.int ,let name = dic["name"]?.string ,let image = dic["image"]?.toImagePath  else {
            return nil
        }
        self.id = id
        self.name = name
        self.image = image
        self.quantity = dic["quantity"]?.string
        self.detailes = dic["description"]?.string
        self.price = dic["price"]?.string
        self.colors = (dic["colors"]?.array)!
    }
}

