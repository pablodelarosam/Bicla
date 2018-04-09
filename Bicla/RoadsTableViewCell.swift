//
//  RoadsTableViewCell.swift
//  Bicla
//
//  Created by Pablo de la Rosa Michicol on 1/21/18.
//  Copyright © 2018 CraftCode. All rights reserved.
//

import UIKit

class RoadsTableViewCell: UITableViewCell {
    
    @IBOutlet var imageRoad: UIImageView!
    @IBOutlet var nameRoad: UILabel!
    @IBOutlet var descriptionRoad: UILabel!
    @IBOutlet var date: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
