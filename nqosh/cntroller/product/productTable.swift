
import UIKit
import CoreData
class productTable: UITableViewController,AddProtocol, UISearchBarDelegate {
    
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var buttonCart: UIButton!
    @IBOutlet weak var lableNoOfCartItem: UILabel?    
    var counterItem = 0

    @IBOutlet var pTable: UITableView!
    var catproduct:catModel?
    var productdata = [productModel]()
    var filterData  = [productModel]()
    var context:NSManagedObjectContext?
    var entity:NSEntityDescription?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        entity = NSEntityDescription.entity(forEntityName: "Order", in: context!)
        searchBar.delegate = self
        pTable.tableFooterView = UIView()
        self.title = catproduct?.name
        setdata()
        pTable.reloadData()
    }
    
    func setdata()  {
    let product = catproduct?.products
        for data in product! {
            
            if let data = data.dictionary ,let info = productModel.init(dic: data) {
                productdata.append(info)
            }
        }
        filterData = productdata
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detailProductSegue", sender: indexPath.row)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pos = indexPath.row
        
        let cell = pTable.dequeueReusableCell(withIdentifier: "productCell" ,for: indexPath) as! productTableViewCell
        cell.addProtocol = self
        cell.addButt.tag = pos
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.productName.text = filterData[indexPath.row].name
        cell.productPrice.text = "ريال" + filterData[indexPath.row].price!
        cell.detailes.text = filterData[indexPath.row].detailes
        let url = URL(string: filterData[indexPath.row].image!)
        cell.productimage.kf.setImage(with: url)
        return cell
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
        filterData = searchText.isEmpty ? productdata : productdata.filter({ (productModel:productModel) -> Bool in
            return productModel.name!.range(of: searchText, options: .caseInsensitive) != nil
        })
        
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let pos:Int = sender as! Int
        if segue.identifier == "detailProductSegue"{
            let destination = segue.destination as! ProductDetail
            destination.productdata = self.productdata[pos]
        }
    }
    


    
    func didPressButton(_ tag: Int, _ sender: UIButton) {
        sender.isHidden = true
        let newOrder = NSManagedObject(entity: entity!, insertInto: context)
        let data:productModel = self.productdata[tag]
        
        newOrder.setValue(data.id, forKey: "id")
        newOrder.setValue(data.name, forKey: "name")
        newOrder.setValue(data.image, forKey: "image")
        newOrder.setValue(data.price, forKey: "price")
        newOrder.setValue(1, forKey: "quantity")
        newOrder.setValue(data.colors[0].string ?? "", forKey: "color")

        do {
            
            try context?.save()
            print("success")
        } catch {
            
            print("Failed saving")
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

   

}
