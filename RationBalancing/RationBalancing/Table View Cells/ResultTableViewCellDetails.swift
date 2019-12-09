//
//  ResultTableViewCellDetails.swift
//  RationBalancing
//
//  Created by student on 7/3/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import UIKit

class ResultTableViewCellDetails: UITableViewCell {

    @IBOutlet weak var ingredients: UILabel!
    @IBOutlet weak var ration: UILabel!
    @IBOutlet weak var nutrients: UILabel!
    @IBOutlet weak var minValue: UILabel!
    @IBOutlet weak var maxValue: UILabel!
    @IBOutlet weak var value: UILabel!
    
    @IBOutlet weak var rationInLbs: UILabel!
    
    
    @IBOutlet weak var outputWithDM: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
