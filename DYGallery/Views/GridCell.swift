//
//  GridCell.swift
//  DYGallery
//
//  Created by Adrià Carro on 27/06/16.
//  Copyright © 2016 DigitalYou. All rights reserved.
//

import UIKit

class GridCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    
    override var selected: Bool {
        didSet {
            self.alpha = self.selected ? 0 : 1.0
        }
    }
    
    var image: String! {
        didSet {
            imageView.image = UIImage(named: image)
        }
    }
    

}
