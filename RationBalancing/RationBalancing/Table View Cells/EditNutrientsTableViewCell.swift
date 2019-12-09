//
//  EditNutrientsTableViewCell.swift
//  RationBalancing
//
//  Created by student on 6/26/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import UIKit

class EditNutrientsTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var minValue: UITextField!
    @IBOutlet weak var maxValue: UITextField!
    @IBOutlet weak var minValueIncrement: UIButton!
    @IBOutlet weak var minValueDec: UIButton!
    @IBOutlet weak var maxValueDecrement: UIButton!
    @IBOutlet weak var maxValueIncrement: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
