import SwiftyJSON

public class catModel:NSObject {
    
    let id : Int?
    let name : String?
    let image : String?
    var products = [JSON]()
    init?(dic:[String:JSON]) {
        guard let id = dic["id"]?.int ,let name = dic["name"]?.string ,let image = dic["image"]?.toImagePath  else {
            return nil
        }
        self.id = id
        self.name = name
        self.image = image
        self.products = (dic["products"]?.array)!
    }
}

