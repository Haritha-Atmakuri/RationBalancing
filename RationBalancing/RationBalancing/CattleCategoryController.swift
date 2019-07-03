//
//  FirstViewController.swift
//  RationBalancing
//
//  Created by student on 6/20/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import UIKit

class CattleCategoryController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == cattleCategory {
            //pickerView1
            return cattle.count
        } else if pickerView == growthRequirement{
            //pickerView2
            return growth.count
        }
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        if pickerView == cattleCategory {
            return cattle[row]
        } else if pickerView == growthRequirement {
            return "\(growth[row])"
        }
        return ""
    }

    var cattleWeightSelected : String = ""
    var cattleCategorySelected : Double = 0.0
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        if pickerView == cattleCategory {
            cattleWeightSelected = cattle[row] as String
            secondTab.value1 = cattleWeightSelected
        }
        else if pickerView == growthRequirement {
            cattleCategorySelected = growth[row] as Double
           secondTab.value2 = cattleCategorySelected
        }
    }

    @IBOutlet weak var cattleCategory: UIPickerView!
    @IBOutlet weak var growthRequirement: UIPickerView!

    var cattle = ["440","550"]
    var growth = [1.1,2.2,3.3,4.4]
    var secondTab : EditNutrientsTableViewController!
    override func viewDidLoad() {
        //Adding the Background Image
        let background = UIImage(named: "cattle1")
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        super.viewDidLoad()
        //
//        self.navigationItem.title = "CATTLE SETTINGS"
        
        
        // This is used to form relation with EditNutrientsTableViewController
        secondTab = self.tabBarController?.viewControllers![2] as! EditNutrientsTableViewController
        //This is used to get default values for pickerview
        cattleCategory.selectRow(0, inComponent: 0, animated: true)
        growthRequirement.selectRow(0, inComponent: 0, animated: true)
        self.cattleCategory.delegate = self
        self.cattleCategory.dataSource = self
        self.growthRequirement.delegate = self
        self.growthRequirement.dataSource = self
    }

    @IBAction func saveBTNTapped(_ sender: Any) {
        secondTab.value1 = cattleWeightSelected
        secondTab.value2 = cattleCategorySelected
        self.tabBarController?.selectedIndex = 2
    }
    
}

