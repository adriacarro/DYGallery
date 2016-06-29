//
//  ProductCell.swift
//  DYGallery
//
//  Created by Adrià Carro on 28/06/16.
//  Copyright © 2016 DigitalYou. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    var product: Product! {
        didSet {
            nameLabel.text = product.name
            imageView.image = UIImage(named: product.image)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
