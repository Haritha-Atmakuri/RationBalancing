//
//  EditNutrientsTableViewController.swift
//  RationBalancing
//
//  Created by student on 6/26/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import UIKit

class EditNutrientsTableViewController: UITableViewController {
    
    var nutrients : [NutrientValues] = []
    var tempNutrients : [TemporaryNutrientValues] = []
    var nutrients1 : [Nutreints] = []
    
    var nutrientsType : [String] = []
    var minValue : [Double] = []
    var maxValue : [Double] = []
    
    var temp1 : [String] = []
    var tempMinValue : [Double] = []
    var tempMaxValue : [Double] = []
    
    var buttons:[Int] = []
    
    var cattleWeight : String?
    var growthrequirement : String?
    var flag2:Int = 0
    var flag:Int = 0

//    var secondTab : DetailViewController!
    
    func generateNutrientValues(){
        if cattleWeight != nil && growthrequirement != nil{
            if flag == 0{
                //print("The value1 is:",cattleWeight!)
                //print("The value1 is:",growthrequirement!)
                nutrientsType = []
                minValue = []
                maxValue = []
                //NutrientsRange.shared.addNutrients()
                nutrients = NutrientList.shared.allNutrients
                for i in 0..<nutrients.count{
                    if nutrients[i].cattleWeight == cattleWeight! && nutrients[i].growthRequirement == growthrequirement!{
                        nutrientsType.append(nutrients[i].nutrientType)
                        minValue.append(nutrients[i].minvalue)
                        maxValue.append(nutrients[i].maxvalue)
                    }
                }
            }
            else{
                nutrientsType = []
                minValue = []
                maxValue = []
                TemporaryNutrientList.shared.retreiveAllTempNutrients()
                tempNutrients = TemporaryNutrientList.shared.allTempNutrients
                for i in 0..<tempNutrients.count{
                    if tempNutrients[i].cattleWeight == cattleWeight! && tempNutrients[i].growthRequirement == growthrequirement!{
                        nutrientsType.append(tempNutrients[i].nutrientType)
                        minValue.append(Double(tempNutrients[i].minvalue))
                        maxValue.append(Double(tempNutrients[i].maxvalue))
                    }
                }
            }
        }
        else{
            let ac = UIAlertController(title:"Please Select the cattle category and CLICK ON CALCULATE to see nutrient range", message:nil, preferredStyle: .alert)
            let proceedAction = UIAlertAction(title:"OK", style: .default)
            {(aia)->Void in
                self.tabBarController?.selectedIndex = 0
                }
            ac.addAction(proceedAction)
            present(ac, animated:true)
        }
    }
    
    override func viewDidLoad() {
        
        AppUtility.lockOrientation(.portrait)
        
        super.viewDidLoad()
        
        self.tableView.rowHeight = 130.0
        
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        let background = UIImage(named: "barrelu")
        let imageView : UIImageView! = UIImageView(frame: view.bounds)
        imageView.image = background
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.center = view.center
        self.tableView.backgroundView = imageView
        generateNutrientValues()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.viewDidLoad()
        tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        AppUtility.lockOrientation(.portrait)
        self.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        AppUtility.lockOrientation(.all)
    }
    //var counts = [Float](repeating: 0, count: 10) //10 is the number of cells here
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return nutrientsType.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int)-> String? {
            return ["Nutrient Type \t\t\t\t\t\t\t\t Min Value \t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t Max Value"][section]
        }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nutrientValues", for: indexPath) as! EditNutrientsTableViewCell
        //      print("in table func: \(nutrients.count)")
        cell.backgroundColor = UIColor(white: 1, alpha: 0.65)
        cell.name.textColor = UIColor.red
        cell.minValue.textColor = UIColor.red
        cell.maxValue.textColor = UIColor.red
        cell.name.text = nutrientsType[indexPath.row]
        cell.name.font = UIFont.init(name: "Helvetica", size: 25)
        cell.minValue.text = "\(String(describing: minValue[indexPath.row]))"
        cell.minValue.font = UIFont.init(name: "Helvetica", size: 25)
        cell.maxValue.text = "\(String(describing: maxValue[indexPath.row]))"
        cell.maxValue.font = UIFont.init(name: "Helvetica", size: 25)
        cell.minValueIncrement.addTarget(self, action: #selector(buttonTapped1(_:)), for: .touchUpInside)
        cell.minValueDec.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        cell.maxValueDecrement.addTarget(self, action: #selector(buttonTapped2(_:)), for: .touchUpInside)
        cell.maxValueIncrement.addTarget(self, action: #selector(buttonTapped3(_:)), for: .touchUpInside)
        // Configure the cell...
        return cell
    }
    
    @objc func buttonTapped(_ button: UIButton) {
        if let indexPath = self.tableView.indexPathForView(button) {
            let cell = self.tableView.cellForRow(at: indexPath) as! EditNutrientsTableViewCell
            var dummy:Float = Float(cell.minValue.text!)!
            if dummy >= 0.5{
                dummy -= 0.5
                cell.minValue.text = "\(dummy)"
            }
        }
    }
    
    @objc func buttonTapped1(_ button: UIButton) {
        if let indexPath = self.tableView.indexPathForView(button) {
            let cell = self.tableView.cellForRow(at: indexPath) as! EditNutrientsTableViewCell
            var dummy:Float = Float(cell.minValue.text!)!
            
            if dummy <= Float(cell.maxValue.text!)! - 0.5{
                dummy += 0.5
                cell.minValue.text = "\(dummy)"
            }
            else{
                let alert = UIAlertController(title: "Error", message: "Min value cannot be greater than max value", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @objc func buttonTapped2(_ button: UIButton) {
        if let indexPath = self.tableView.indexPathForView(button) {
            let cell = self.tableView.cellForRow(at: indexPath) as! EditNutrientsTableViewCell
            var dummy:Float = Float(cell.maxValue.text!)!
            if dummy >= Float(cell.minValue.text!)! + 0.5{
                dummy -= 0.5
                cell.maxValue.text = "\(dummy)"
            }
            else{
                let alert = UIAlertController(title: "Error", message: "Max value cannot be less than min value", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @objc func buttonTapped3(_ button: UIButton) {
        if let indexPath = self.tableView.indexPathForView(button) {
            let cell = self.tableView.cellForRow(at: indexPath) as! EditNutrientsTableViewCell
            var dummy:Float = Float(cell.maxValue.text!)!
            dummy += 0.5
            cell.maxValue.text = "\(dummy)"
        }
    }
    
    @IBAction func reset(_ sender: Any) {
        //print("Inside reset function")
        flag = 0
        let ac = UIAlertController(title:"Do you want to reset your values", message:nil, preferredStyle: .alert)
        let proceedAction = UIAlertAction(title:"Yes", style: .default)
        {(aia)->Void in
            //(self.tabBarController?.selectedIndex = 1)
            TemporaryNutrientsRange.shared.deletePreviousData()
            TemporaryNutrientList.shared.removeNutrients()
            self.viewDidLoad()
            self.tableView.reloadData()
        }
        // .text is a String?, so we must unwrap it
        let cancelAction = UIAlertAction(title:"NO", style: .cancel, handler:nil)
        ac.addAction(proceedAction)
        ac.addAction(cancelAction)
        present(ac, animated:true)
    }
    
    @IBAction func save(_ sender: Any) {
        tempMinValue = []
        tempMaxValue = []
        TemporaryNutrientsRange.shared.deletePreviousData()
        TemporaryNutrientList.shared.removeNutrients()
        for i in 0 ..< self.tableView.numberOfRows(inSection: 0){
            let cell: EditNutrientsTableViewCell = self.tableView.cellForRow(at: IndexPath(row: i, section: 0)) as! EditNutrientsTableViewCell
            TemporaryNutrientsRange.shared.addNutrients(nutrient: TemporaryNutreints(cattleWeight: cattleWeight!, growthRequirement: growthrequirement!, nutrientType: cell.name.text!, minvalue: Float(cell.minValue.text!)!, maxvalue: Float(cell.maxValue.text!)!))
            TemporaryNutrientList.shared.saveTemporaryIngredient(tempNutrientValue: TemporaryNutrientValues(cattleWeight: cattleWeight!, growthRequirement: growthrequirement!, maxvalue: Double(cell.maxValue.text!)!, minvalue: Double(cell.minValue.text!)!, nutrientType: cell.name.text!))
            //self.temp1.append(cell.name.text!)
            self.tempMinValue.append(Double(cell.minValue.text!)!)
            self.tempMaxValue.append(Double(cell.maxValue.text!)!)
            flag=1
            //print(nutrients1)
        }
            for i in 0..<tempMinValue.count
            {
                //flag2 = 0
                if tempMinValue[i] >= tempMaxValue[i] || tempMaxValue[i] <= tempMinValue[i]{
                    let alert = UIAlertController(title: "Error", message: "Max and Min constraints not met", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    generateNutrientValues()
                    self.tableView.reloadData()
                    //flag2 = flag2 + 1
                    break
                }
                else if tempMinValue[i] < 0.0{
                    let alert = UIAlertController(title: "Error", message: "Min value cannot be negative", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    generateNutrientValues()
                    self.tableView.reloadData()
                    //flag2 = flag2 + 1
                    break
                }
                else if tempMaxValue[i] < 0.0{
                    let alert = UIAlertController(title: "Error", message: "Max value cannot be negative", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    generateNutrientValues()
                    self.tableView.reloadData()
                    //flag2 = flag2 + 1
                    break
                }
//                else if flag2 != 0{
//                let alert = UIAlertController(title: "Error", message: "Max and Min constraints not met", preferredStyle: UIAlertController.Style.alert)
//                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//                           self.present(alert, animated: true, completion: nil)
//            }
//            else{
//                    flag = 1
//                let ac = UIAlertController(title: "SUCESS", message: "SAVED SUCESSFULLY", preferredStyle: UIAlertController.Style.alert)
//                let stayHere = UIAlertAction(title:"STAY HERE", style: .default)
//                {(aia)->Void in
//                    self.viewDidLoad()
//                    self.tableView.reloadData()
//                }
//                let proceedForward = UIAlertAction(title:"Proceed Forward", style: .cancel){(aia)->Void in
//                    self.tabBarController?.selectedIndex = 1
//                }
//                ac.addAction(stayHere)
//                ac.addAction(proceedForward)
//                present(ac, animated:true)
//            }
        }
    }
}

public extension UITableView {
    
    /**
     This method returns the indexPath of the cell that contains the specified view
     - Parameter view: The view to find.
     - Returns: The indexPath of the cell containing the view, or nil if it can't be found
     */
    
    func indexPathForView(_ view: UIView) -> IndexPath? {
        let center = view.center
        //print("center: \(center)")
        //The center of the view is a better point to use, but we can only use it if the view has a superview
        guard let superview = view.superview else {
            //The view we were passed does not have a valid superview.
            //Use the view's bounds.origin and convert from the view's coordinate system
            let origin = self.convert(view.bounds.origin, from: view)
            let indexPath = self.indexPathForRow(at: origin)
            return indexPath
        }
        let viewCenter = self.convert(center, from: superview)
        //        print("viewcenter: \(viewCenter)")
        let indexPath = self.indexPathForRow(at: viewCenter)
        //        print("After loop: \(indexPath)")
        return indexPath
    }
}



//
//    override func performSegue(withIdentifier identifier: String, sender: Any?) {
//        if(identifier == "cattleSettings" || identifier == ""){
//            let alert = UIAlertController(title: "Error", message: "do you want to save recently edited nutrient values", preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        }
//    }



