//
//  NewsViewCell.swift
//  Bicla
//
//  Created by Gerardo de la Rosa on 4/10/18.
//  Copyright © 2018 CraftCode. All rights reserved.
//

import UIKit

class NewsViewCell: UITableViewCell {
    
    @IBOutlet var imageRoad: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var desc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
