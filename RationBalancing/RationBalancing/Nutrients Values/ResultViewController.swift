//
//  ResultViewController.swift
//  RationBalancing
//
//  Created by student on 7/3/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var result1TVC: UITableView!
    @IBOutlet weak var result2TVC: UITableView!
    
    var outputValues:[Double]?
    var outputValueswithDM:[Double]?
    var nutrientsType : [String]?
    var nutrientMinValue : [Double]?
    var nutrientMaxValue : [Double]?
    var nutrientRangeValues:[Double]?
    var sortedNutrientType:[String]?
    var rationInLbs:[Double]?
    
    var finalNutrientRangeValues:[Double]?
    var outputValuesSum:Double = 0.0
    
    override func viewDidLoad() {
        AppUtility.lockOrientation(.portrait)
        super.viewDidLoad()
        self.result1TVC.delegate = self
        self.result1TVC.dataSource = self
        self.result2TVC.delegate = self
        self.result2TVC.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppUtility.lockOrientation(.portrait)
        self.result1TVC.reloadData()
        self.result2TVC.reloadData()
        sortedNutrientType = DetailViewController.selectedIngredients.sorted(by: {$0<$1})
       calculatingResult()
    }
    
    func calculatingResult(){
        outputValuesSum = 0.0
        for i in 0..<outputValues!.count{
            outputValuesSum = outputValues![i] + outputValuesSum
        }
        print("The outputs values sum is:",outputValuesSum)
        
        for i in 0..<outputValues!.count{
            outputValues![i] = outputValues![i]/outputValuesSum * 100
        }
        
//        for i in 0..<nutrientRangeValues!.count{
//            finalNutrientRangeValues?.append(nutrientRangeValues![i]/outputValuesSum)
//        }
//        for i in 0..<nutrientRangeValues!.count{
//            if nutrientRangeValues![i] < nutrientMinValue![i] && nutrientRangeValues![i] >= nutrientMinValue![i]-0.2{
//                nutrientRangeValues![i].round(.up)
//            }
//            if nutrientRangeValues![i] > nutrientMaxValue![i] && nutrientRangeValues![i] <= nutrientMaxValue![i]+0.2{
//                nutrientRangeValues![i].round(.down)
//            }
//        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int)-> String? {
        if tableView == self.result1TVC {
                return ["Ration Details of Ingredients \t\t\t\t\t\t\t\t in lbs \t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t in % \t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t with DM"] [section]
        }
        if tableView == self.result2TVC {
            return ["Nutrient Type \t\t\t\t Min Value \t\t\t\t\t\t\t\t Max Value \t\t\t\t\t\t\t\t\t\t\t\t\t\t\t Obtained Value"][section]
        }
        return [""][section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.result1TVC {
            return DetailViewController.selectedIngredients.count
        }
        if tableView == self.result2TVC {
            return nutrientsType!.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.result1TVC {
           let cell = tableView.dequeueReusableCell(withIdentifier: "result1", for: indexPath) as! ResultTableViewCellDetails
            cell.ingredients.text = sortedNutrientType![indexPath.row]
            cell.rationInLbs.text = String(format:"%0.3f",rationInLbs![indexPath.row])+" lbs"
            cell.ration.text = String(format:"%0.2f",outputValues![indexPath.row])+" %"
            cell.outputWithDM.text = String(format:"%0.3f",outputValueswithDM![indexPath.row])+" lbs"
            //cell.ingredients.text!
            //cell.ingredients!.text = DetailViewController.selectedIngredients[indexPath.row]
            return cell
        }
        
        if tableView == self.result2TVC {
            let cell = tableView.dequeueReusableCell(withIdentifier: "result2") as! ResultTableViewCellDetails
            if nutrientRangeValues![indexPath.row] < nutrientMinValue![indexPath.row]{
                cell.backgroundColor = UIColor.red
            }
            else if  nutrientRangeValues![indexPath.row] > nutrientMaxValue![indexPath.row]{
                 cell.backgroundColor = UIColor.blue
            }
            else{
                cell.backgroundColor = UIColor.green
            }
            cell.nutrients.text = nutrientsType![indexPath.row]
            cell.minValue.text = String(format:"%0.2f",nutrientMinValue![indexPath.row])
            cell.maxValue.text = String(format:"%0.2f",nutrientMaxValue![indexPath.row])
            cell.value.text = String(format:"%0.3f",nutrientRangeValues![indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}
