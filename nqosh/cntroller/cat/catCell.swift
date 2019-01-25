
import UIKit

class catCell: UICollectionViewCell {
    @IBOutlet weak var catImage: UIImageView!
    
    @IBOutlet weak var catName: UILabel!
    override var isSelected: Bool{
        didSet{
            
            if self.isSelected
            {
                self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }
            else
            {
                self.transform = CGAffineTransform.identity
            }

        }
        }
    }

