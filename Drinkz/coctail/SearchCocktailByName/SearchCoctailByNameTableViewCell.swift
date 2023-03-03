//
//  SearchCoctailByNameTableViewCell.swift
//  Drinkz
//
//  Created by Daniel on 03/03/2023.
//

import UIKit

class SearchCoctailByNameTableViewCell: UITableViewCell {

    @IBOutlet weak var cocktailImage: UIImageView!
    
    @IBOutlet weak var cocktailLabel: UILabel!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cocktailImage.layer.cornerRadius = 25
    }

}
