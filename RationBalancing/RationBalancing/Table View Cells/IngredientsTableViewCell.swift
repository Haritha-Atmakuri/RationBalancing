//
//  IngredientsTableViewCell.swift
//  RationBalancing
//
//  Created by Student on 9/26/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import UIKit

class IngredientsTableViewCell: UITableViewCell {

    override func prepareForReuse() {
        // invoke superclass implementation
        super.prepareForReuse()
        // reset (hide) the checkmark label
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //self.accessoryType = selected ? .checkmark : .none
        // Configure the view for the selected state
    }

}
