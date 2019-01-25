import UIKit
import Kingfisher
class HomeVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var activityindecator: UIActivityIndicatorView!
    var dataArr = [catModel]()
    @IBOutlet weak var catcollection: UICollectionView!
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named:"background")
        iv.contentMode = .scaleAspectFill
        return iv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityindecator.transform = CGAffineTransform(scaleX: 3, y: 3)
        self.activityindecator.isHidden = false
        self.catcollection.isHidden = true
        self.activityindecator.startAnimating();
        if CheckInternet.Connection(){
            self.getdata()
        }else{
            self.showAlert(message: NSLocalizedString("لا يوجد اتصال بالانترنت", comment: ""))
        }
        self.catcollection?.backgroundView = imageView
        self.catcollection!.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        if let layout = catcollection.collectionViewLayout as? UICollectionViewFlowLayout {
            let itemWidth = view.bounds.width / 2.3
            let itemHeight = layout.itemSize.height
            layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
            layout.invalidateLayout()
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.activityindecator.isHidden = true
        self.catcollection.isHidden = false
        self.activityindecator.stopAnimating()
    }
    func getdata()  {
        Api.categories { (error:Error?, data:[catModel]?) in
         self.dataArr = data!
            self.catcollection.reloadData()
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = catcollection.dequeueReusableCell(withReuseIdentifier: "CatCell", for: indexPath)as? catCell else{return UICollectionViewCell()}
        cell.catName.text = dataArr[indexPath.row].name
        let url = URL(string: dataArr[indexPath.row].image!)
        cell.catImage.kf.setImage(with: url)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let catid = dataArr[indexPath.row].id
        if catid == 6{
            self.performSegue(withIdentifier: "serviceSegue", sender: self)
        }else{
            self.performSegue(withIdentifier: "productsegue", sender: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "productsegue" {
            let destinationVC = segue.destination as! productTable
            let indexpathes = self.catcollection.indexPathsForSelectedItems
            let indexpath = indexpathes![0] as NSIndexPath
            let dataarr = self.dataArr[indexpath.row]
            destinationVC.catproduct = dataarr
        }
    }
}

