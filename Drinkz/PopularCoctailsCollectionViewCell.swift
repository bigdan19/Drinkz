//
//  PopularCoctailsCollectionViewCell.swift
//  Drinkz
//
//  Created by Daniel on 13/02/2023.
//

import UIKit

class PopularCoctailsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        image.layer.cornerRadius = 60
    }

}
