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

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        if pickerView == cattleCategory {
            cattleWeightSelected = cattle[row] as String
            //secondTab.value1 = cattleWeightSelected
        }
        else if pickerView == growthRequirement {
            cattleCategorySelected = growth[row] as String
           //secondTab.value2 = cattleCategorySelected
        }
    }

    @IBOutlet weak var cattleCategory: UIPickerView!
    @IBOutlet weak var growthRequirement: UIPickerView!
    
    //This is customButton used for the calculate
    var bottomCustomButton = CustomButton()
    
    var cattle = ["Select Cattle Weight","450-550 lbs","550-650 lbs","650-750 lbs"]
    var growth = ["Select Cattle Category","1.1 kgs","2.2 kgs","3.3 kgs","4.4 kgs"]
    
    var cattleWeightSelected : String = "Select Cattle Weight"
    var cattleCategorySelected : String = "Select Cattle Category"
    
    var ingres:[Ingredients] = []
    
    var secondTab : EditNutrientsTableViewController!
    var firstTab : MasterTableViewController!
    
    override func viewDidLoad() {
        //Setting the button with the better UI
        setupBottomButtonConstraints()
        addActionToBottomButton()
        bottomCustomButton.setTitle("Calculate", for: .normal)
        
        super.viewDidLoad()
        AppUtility.lockOrientation(.portrait)
        
        // This is used to form relation with EditNutrientsTableViewController
        secondTab = (self.tabBarController?.viewControllers![1] as! EditNutrientsTableViewController)
        
        
//        let tab = (self.tabBarController?.viewControllers![1] as! UISplitViewController)
//        firstTab = tab.viewControllers[0] as? MasterTableViewController
//
        
        self.cattleCategory.delegate = self
        self.cattleCategory.dataSource = self
        self.growthRequirement.delegate = self
        self.growthRequirement.dataSource = self
    }
    
    func setupBottomButtonConstraints() {
        view.addSubview(bottomCustomButton)
        bottomCustomButton.translatesAutoresizingMaskIntoConstraints = false
        bottomCustomButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        bottomCustomButton.widthAnchor.constraint(equalToConstant: 280).isActive = true
        bottomCustomButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bottomCustomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive = true
    }


    func addActionToBottomButton() {
        bottomCustomButton.addTarget(self, action: #selector(bottomButtonTapped), for: .touchUpInside)
    }

    @objc func bottomButtonTapped() {
        bottomCustomButton.shake()
        if cattleWeightSelected == "" || cattleCategorySelected == "" || cattleWeightSelected == "Select Cattle Weight" ||
            cattleCategorySelected == "Select Cattle Category"{
            //secondTab.cattleWeight = cattleWeightSelected
            //secondTab.growthrequirement = cattleCategorySelected
            let ac = UIAlertController(title:"Please select Cattle Category", message:nil, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title:"Cancel", style: .cancel, handler:nil)
            ac.addAction(cancelAction)
            present(ac, animated:true)
        }
        else{
            secondTab.cattleWeight = cattleWeightSelected
            secondTab.growthrequirement = cattleCategorySelected
            //            firstTab.cattleWeight = cattleWeightSelected
            //            firstTab.growthrequirement = cattleCategorySelected
            self.tabBarController?.selectedIndex = 1
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppUtility.lockOrientation(.portrait)
    }
  

}

