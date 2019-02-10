//
//  ColorCell.swift
//  nqosh
//
//  Created by emad on 05/06/1440 AH.
//  Copyright © 1440 Hesham. All rights reserved.
//

import UIKit

class ColorCell: UICollectionViewCell {
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
