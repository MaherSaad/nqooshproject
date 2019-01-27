
import UIKit
class productTable: UITableViewController,AddProtocol {
    
    
    
    @IBOutlet weak var buttonCart: UIButton!
    @IBOutlet weak var lableNoOfCartItem: UILabel?    
    var counterItem = 0

    @IBOutlet var pTable: UITableView!
    var catproduct:catModel?
    var productdata = [productModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productdata.count
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
        cell.productName.text = productdata[indexPath.row].name
        cell.productPrice.text = "ريال" + productdata[indexPath.row].price!
        cell.detailes.text = productdata[indexPath.row].detailes
        let url = URL(string: productdata[indexPath.row].image!)
        cell.productimage.kf.setImage(with: url)
        return cell
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
