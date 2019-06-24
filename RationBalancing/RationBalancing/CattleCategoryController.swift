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
        <#code#>
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        <#code#>
    }
    

//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        if pickerView == cattleCategory {
//            //pickerView1
//            return cattle.count
//        } else if pickerView == growthRequirement{
//            //pickerView2
//            return growth.count
//        }
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//
//        if pickerView == cattleCategory {
//            return cattle[row]
//        } else if pickerView == growthRequirement {
//            return "\(growth[row])"
//        }
//        return ""
//    }
//
    @IBOutlet weak var cattleCategory: UIPickerView!
    @IBOutlet weak var growthRequirement: UIPickerView!
//
//    var cattle = ["400lb","600lb","750lb","900lb"]
//    var growth = [2,2.5,3,3.5,4,4.5]
    
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

        self.cattleCategory.delegate = self
        self.cattleCategory.dataSource = self
        self.growthRequirement.delegate = self
        self.growthRequirement.dataSource = self
    }

}

