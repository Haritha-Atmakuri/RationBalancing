//
//  EditNutrientsTableViewController.swift
//  RationBalancing
//
//  Created by student on 6/26/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import UIKit

class EditNutrientsTableViewController: UITableViewController {

    var nutrients : [Nutreints] = []
    var nutrients1 : [Nutreints] = []
    var nutrientsType : [String] = []
    var nutrientValue : [Float] = []
    var nutrientValue1 : [Float] = []
    var temp1 : [String] = []
    var temp2 : [Float] = []
    var buttons:[Int] = []
    var value1 : String?
    var value2 : Double?
    override func viewDidLoad() {
        super.viewDidLoad()
        nutrientsType = []
        nutrientValue = []
        nutrientValue1 = []
        temp1 = []
        temp2 = []
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        let background = UIImage(named: "cattle1")
        let imageView : UIImageView! = UIImageView(frame: view.bounds)
        imageView.image = background
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.center = view.center
        self.tableView.backgroundView = imageView
        
        NutrientsRange.shared.addNutrients()
        nutrients = NutrientsRange.shared.nutrients
        //        if temp1.isEmpty && temp2.isEmpty{
        if value1 != nil && value2 != nil{
            for i in 0..<nutrients.count{
                if nutrients[i].cattleWeight == value1! && nutrients[i].growthRequirement == value2!{
                    nutrientsType.append(nutrients[i].nutrientType)
                    nutrientValue.append(nutrients[i].minvalue)
                    nutrientValue1.append(nutrients[i].maxvalue)
                }
            }
        }
        //        }
        //        else{
        //            for i in 0..<nutrients.count{
        //                if nutrients[i].cattleWeight == value1! && nutrients[i].growthRequirement == value2!{
        //            nutrientsType = temp1
        //            nutrientValue = temp2
        //                }
        //            }
        //        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewDidLoad()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return nutrientsType.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nutrientValues", for: indexPath) as! EditNutrientsTableViewCell
        //      print("in table func: \(nutrients.count)")
        cell.backgroundColor = UIColor(white: 1, alpha: 0.65)
        cell.name.textColor = UIColor.red
        cell.value.textColor = UIColor.red
        cell.value1.textColor = UIColor.red
        cell.name.text = nutrientsType[indexPath.row]
        cell.value.text = "\(String(describing: nutrientValue[indexPath.row]))"
        cell.value1.text = "\(String(describing: nutrientValue1[indexPath.row]))"
//        cell.minValueIncrement.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
//        cell.minValueDec.addTarget(self, action: #selector(buttonTapped1(_:)), for: .touchUpInside)
//        cell.maxValueDecrement.addTarget(self, action: #selector(buttonTapped2(_:)), for: .touchUpInside)
//        cell.maxValueIncrement.addTarget(self, action: #selector(buttonTapped3(_:)), for: .touchUpInside)
        // Configure the cell...
        return cell
    }
    
//    @objc func buttonTapped(_ button: UIButton) {
//        if let indexPath = self.tableView.indexPathForView(button) {
//            let cell = self.tableView.cellForRow(at: indexPath) as! EditNutrientsTableViewCell
//            var dummy:Float = Float(cell.value.text!)!
//            dummy += 0.1
//            cell.value.text = "\(dummy)"
//        }
//    }
//
//    @objc func buttonTapped1(_ button: UIButton) {
//        if let indexPath = self.tableView.indexPathForView(button) {
//            let cell = self.tableView.cellForRow(at: indexPath) as! EditNutrientsTableViewCell
//            var dummy:Float = Float(cell.value.text!)!
//
//            if dummy <= Float(cell.value1.text!)! && dummy >= 0{
//                dummy -= 0.1
//                cell.value.text = "\(dummy)"
//            }
//            else{
//                let alert = UIAlertController(title: "Error", message: "Min value cannot be greater than max value or greater than zero", preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//            }
//        }
//    }
//
//    @objc func buttonTapped2(_ button: UIButton) {
//        if let indexPath = self.tableView.indexPathForView(button) {
//            let cell = self.tableView.cellForRow(at: indexPath) as! EditNutrientsTableViewCell
//            var dummy:Float = Float(cell.value1.text!)!
//            if dummy <= Float(cell.value1.text!)! && dummy >= 0{
//                dummy -= 0.1
//                cell.value1.text = "\(dummy)"
//            }
//            else{
//                let alert = UIAlertController(title: "Error", message: "Min value cannot be greater than max value or greater than zero", preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//            }
//        }
//    }
//
//    @objc func buttonTapped3(_ button: UIButton) {
//        if let indexPath = self.tableView.indexPathForView(button) {
//            let cell = self.tableView.cellForRow(at: indexPath) as! EditNutrientsTableViewCell
//            var dummy:Float = Float(cell.value1.text!)!
//            dummy += 0.1
//            cell.value1.text = "\(dummy)"
//        }
//    }
    

    @IBAction func save(_ sender: Any) {
        print("Inside save method")
        print(nutrientsType)
        temp1 = []
        temp2 = []
        for i in 0 ..< self.tableView.numberOfRows(inSection: 0){
            let cell: EditNutrientsTableViewCell = self.tableView.cellForRow(at: IndexPath(row: i, section: 0)) as! EditNutrientsTableViewCell
           self.temp1.append(cell.name.text!)
           self.temp2.append(Float(cell.value.text!)!)
//            self.nutrients1.append(Nutreints(cattleWeight: value1!, growthRequirement: value2!, nutrientType: cell.name.text!, minvalue: Float(cell.value.text!)!))
        }
        print(nutrients1)
        self.tabBarController?.selectedIndex = 0
    }
}


//public extension UITableView {
//
//    /**
//     This method returns the indexPath of the cell that contains the specified view
//     - Parameter view: The view to find.
//     - Returns: The indexPath of the cell containing the view, or nil if it can't be found
//     */
//
//    func indexPathForView(_ view: UIView) -> IndexPath? {
//        let center = view.center
//        print("center: \(center)")
//        //The center of the view is a better point to use, but we can only use it if the view has a superview
//        guard let superview = view.superview else {
//            //The view we were passed does not have a valid superview.
//            //Use the view's bounds.origin and convert from the view's coordinate system
//            let origin = self.convert(view.bounds.origin, from: view)
//            let indexPath = self.indexPathForRow(at: origin)
//            return indexPath
//        }
//        let viewCenter = self.convert(center, from: superview)
//        //        print("viewcenter: \(viewCenter)")
//        let indexPath = self.indexPathForRow(at: viewCenter)
//        //        print("After loop: \(indexPath)")
//        return indexPath
//    }
//}
