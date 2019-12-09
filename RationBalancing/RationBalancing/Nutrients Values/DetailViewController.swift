//
//  DetailViewController.swift
//  RationBalancing
//
//  Created by student on 6/20/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate {
    
    @IBOutlet weak var calculateButton: UIBarButtonItem!
    @IBOutlet weak var selectedICattleWeight: UILabel!
    @IBOutlet weak var selectedCattleCategory: UILabel!
    @IBOutlet weak var webView: UIWebView!
    
    var secondTab : EditNutrientsTableViewController!
    var thirdTab:MasterTableViewController!
    //This gives the selected ingridients present from the master view controller
    static var selectedIngredients:[String] = []
    //This will contains the all the total list of ingridients present in the backendless.
    var ingredientList:[Ingredients] = []
    //This gives the sorted ingridients list od the selected one's
    var sortedIngredientList:[Ingredients] = []
    //This gives the temporary nurtients list i.e; If there are any changes in the nutrients
    var temNutrientList:[TemporaryNutrientValues] = []
    
    var rationValues:[Double] = []
    var cellValues:[String] = []
    var cost:[String] = []
    var lbsInRation:[Double] = []
    
    var ingDic:[String:Double] = [:]
    
    
    var coefficients:[String] = []
    
    var negLHS:String = ""
    var caLHS:String = ""
    var pLHS:String = ""
    var nemLHS:String = ""
    var cpLHS:String = ""
    
    var neg:[Double] = []
    var ca:[Double] = []
    var p:[Double] = []
    var nem:[Double] = []
    var cp:[Double] = []
    
    var lhsEquation:[String] = []
    
    var costEquation:String = ""
    var equationWithHundred:String = ""
    
    var generateEquation1:String = ""
    var finalEquation:String = ""
    
    var outputResult:[Double] = []
    
    var valuesWithDM:[Double] = []
    var outputResultWithDM:[Double] = []
    
    var nutrientsType : [String] = []
    var nutrientMinValue : [Double] = []
    var nutrientMaxValue : [Double] = []
    
    var nutrientRangeValues:[Double] = []
    
    var count = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int)-> String? {
        return ["SELECTED INGREDIENTS \t\tEnter Ration \t\t\t  Enter Cost(*)"][section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0{
        return DetailViewController.selectedIngredients.count
//        }
//        else{
//            return DetailViewController.selectedIngredients.count
//        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.section == 0{
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedIngredients", for: indexPath) as! RationTableCellDetails
        cell.costTF.keyboardType = .phonePad
        cell.percentageTF.keyboardType = .phonePad
        cell.textLabel!.text = sortedIngredientList[indexPath.row].name
        //generateEquation(count: indexPath.row)
        return cell
//        }
//        else{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "Result", for: indexPath)
//            return cell
//        }
    }
    
    // this method handles row deletion
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            DetailViewController.selectedIngredients.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        tableView.reloadData()
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        secondTab = (self.tabBarController?.viewControllers![1] as! EditNutrientsTableViewController)
        //thirdTab = (self.tabBarController?.viewControllers![2] as! MasterTableViewController)
        
        if secondTab.nutrientsType != []{
            self.tableView.delegate = self
            self.tableView.dataSource = self
            
            selectedICattleWeight.text = secondTab.cattleWeight
            selectedCattleCategory.text = secondTab.growthrequirement
            
            ingredientList = Ingreed.shared.allIngredients
            //print(ingredientList.count)
            eqvalue = ""
            coefficients = []
            lhsEquation = []
            loadingTheLocalValues()
        }
        else{
            let ac = UIAlertController(title:"Please Select the cattle category and CLICK ON CALCULATE to see Ingredients List", message:nil, preferredStyle: .alert)
            let proceedAction = UIAlertAction(title:"OK", style: .default)
            {(aia)->Void in
            self.tabBarController?.selectedIndex = 0
            }
            ac.addAction(proceedAction)
            present(ac, animated:true)
        }
    }
    
    func loadingTheLocalValues(){
        temNutrientList = []
        nutrientsType = []
        nutrientMinValue = []
        nutrientMaxValue = []
        
        if TemporaryNutrientList.shared.countOfTempNutrients() != 0{
            //print("Inside checking the temporary list")
            TemporaryNutrientList.shared.retreiveAllTempNutrients()
            temNutrientList = TemporaryNutrientList.shared.allTempNutrients
            for i in temNutrientList{
                //print(i.minvalue)
                nutrientsType.append(i.nutrientType)
                nutrientMinValue.append(i.minvalue)
                nutrientMaxValue.append(i.maxvalue)
            }
        }
        else{
            nutrientsType = secondTab.nutrientsType
            nutrientMinValue = secondTab.minValue
            nutrientMaxValue = secondTab.maxValue
        }
        //print("The array nutrients are",secondTab.nutrientsType)
        tableView.reloadData()
        
        coefficients = []
        equationWithHundred = ""
        generateCoefficients()
        generateEquationWithHundred()
        generateSortedIngridientList()
        generateLHSEquation()
        lhsEquation = []
        generateEquation1 = ""
        generateEq1()
        eqvalue = ""
        self.cost = []
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //print(DetailViewController.selectedIngredients.count)
        //checkingHtmlFile()
        //print("Hey it's view will appear of detail view controller")
        viewDidLoad()
        calculateButton.isEnabled = true
        //loadingTheLocalValues()
    }
    
    
    
    func generateCoefficients(){
        //var count = 0
        coefficients = []
        if sortedIngredientList.count != 0{
            for i in sortedIngredientList{
                coefficients.append(i.name.replacingOccurrences(of: "\\s", with: "", options: NSString.CompareOptions.literal, range: nil).replacingOccurrences(of: ".", with: "", options: NSString.CompareOptions.literal, range: nil).replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil).replacingOccurrences(of: ",", with: "", options: NSString.CompareOptions.literal, range: nil).replacingOccurrences(of: "/", with: "", options: NSString.CompareOptions.literal, range: nil).replacingOccurrences(of: "_", with: "", options: NSString.CompareOptions.literal, range: nil).replacingOccurrences(of: "%", with: "", options: NSString.CompareOptions.literal, range: nil).replacingOccurrences(of: "$", with: "", options: NSString.CompareOptions.literal, range: nil).replacingOccurrences(of: "@", with: "", options: NSString.CompareOptions.literal, range: nil).replacingOccurrences(of: "!", with: "", options: NSString.CompareOptions.literal, range: nil).replacingOccurrences(of: "&", with: "", options: NSString.CompareOptions.literal, range: nil).replacingOccurrences(of: "*", with: "", options: NSString.CompareOptions.literal, range: nil).replacingOccurrences(of: "~", with: "", options: NSString.CompareOptions.literal, range: nil).replacingOccurrences(of: "`", with: "", options: NSString.CompareOptions.literal, range: nil).replacingOccurrences(of: "`", with: "", options: NSString.CompareOptions.literal, range: nil))
            }
        }
    }
    
    func generateEquationWithHundred(){
        equationWithHundred = ""
        for i in coefficients{
            if equationWithHundred == ""{
                equationWithHundred = i
            }
            else{
            equationWithHundred = equationWithHundred + "+\(i)"
            }
        }
        equationWithHundred = equationWithHundred + "=100"
        //print(equationWithHundred)
    }
    
    func generateSortedIngridientList(){
        for i in ingredientList{
            if DetailViewController.selectedIngredients.contains(i.name){
            sortedIngredientList.append(i)
            //print("These are the value of i into sorted ingridient list",i.name)
            }
        }
        
        neg = []
        ca = []
        p = []
        nem = []
        cp = []
        for i in sortedIngredientList{
            neg.append(i.NEg/100)
            ca.append(i.Ca)
            p.append(i.P)
            nem.append(i.NEm/100)
            cp.append(i.CP)
        }
        
    }
    

    func generateLHSEquation(){
        var value = ""
        var value1 = ""
        var value2 = ""
        var value3 = ""
        var value4 = ""
        
        lhsEquation = []
        
        let count1 = coefficients.count-1
        var count2 = 0
        
     
        
        for i in coefficients{
            if count2<=count1{
                if value == "" || value1 == "" || value2 == "" || value3 == "" || value4 == ""{
                    value = "\(neg[count2])\(i)"
                    value1 = "\(ca[count2])\(i)"
                    value2 = "\(p[count2])\(i)"
                    value3 = "\(nem[count2])\(i)"
                    value4 = "\(cp[count2])\(i)"
                    count2 = count2+1
                }
                else{
                    value = value + "+\(neg[count2])\(i)"
                    value1 = value1 + "+\(ca[count2])\(i)"
                    value2 = value2 + "+\(p[count2])\(i)"
                    value3 = value3 + "+\(nem[count2])\(i)"
                    value4 = value4 + "+\(cp[count2])\(i)"
                    count2 = count2+1
                }
            }
        }
        
        if negLHS == "" && caLHS == "" && pLHS == "" && nemLHS == ""{
        negLHS = value
        caLHS = value1
        pLHS = value2
        nemLHS = value3
        cpLHS = value4
        }
    }
    
    func generateEq1(){
        generateEquation1 = ""
        //var generateEquationValues = ""
        //let nutrientCount = nutrientsType.count
        if nutrientsType != []{
            //print(nutrientMinValue[1])
//            for i in 0..<nutrientCount{
//                generateEquationValues = "\(lhsEquation[i])<=\(nutrientValue1[i])\\n\(lhsEquation[i])>=\(nutrientValue[i])\\n" + generateEquationValues
//            }
            generateEquation1 = "\(cpLHS)<=\(nutrientMaxValue[1])\\n\(cpLHS)>=\(nutrientMinValue[1])\\n\(caLHS)<=\(nutrientMaxValue[0])\\n\(caLHS)>=\(nutrientMinValue[0])\\n\(pLHS)<=\(nutrientMaxValue[2])\\n\(pLHS)>=\(nutrientMinValue[2])\\n\(negLHS)<=\(nutrientMaxValue[3])\\n\(negLHS)>=\(nutrientMinValue[3])\\n\(nemLHS)<=\(nutrientMaxValue[4])\\n\(nemLHS)>=\(nutrientMinValue[4])"
            //print("T##items: Any...##Any: \(generateEquation1)" )
        }
       // print("The generate equation is:",generateEquationValues)
    }
    
    
    var eqvalue = ""
    func generateCostEquation(){
        //print("The value of coefficients",coefficients)
        let count1 = cost.count - 1
        var count3 = 0
        //print("The value of count1",count1)
            if self.count == 0 && self.cost != []{
                for i in self.coefficients{
                    if count3<=count1{
                        //print("count1 value is:",count1)
                        //print("count3 value is:",count3)
                        if self.eqvalue == ""{
                            self.eqvalue = "\(self.cost[count3])\(i)"
                            count3 = count3+1
                        }
                        else{
                            //print("Inside else count3 is:",count3)
                            self.eqvalue = self.eqvalue + "+\(self.cost[count3])\(i)"
                            count3 = count3+1
                        }
                    }
                }
                if self.costEquation == ""{
                    self.costEquation = self.eqvalue
                }
            }
    }
    
    func generateEquation(){
        //var str = "Minimize p=\(costEquation) subject to\n"+generateEquation1
        if finalEquation == ""{
        //finalEquation = "Minimizep=\(costEquation)subjectto\\\\n\(generateEquation1)"
        finalEquation = "Minimizep=\(costEquation)subjectto\\n\(generateEquation1)"
        }
        //print(finalEquation)
    }
    
    func checkingHtmlFile(){
        //print("Inside html function")
        if let url = Bundle.main.path(forResource:"index", ofType: "html"){
            //print("Inside if let")
            let urlPath = URL (fileURLWithPath:url)
            let request = URLRequest(url:urlPath)
            webView.delegate = self
            //This view controller is webview delegate
            webView.loadRequest(request)
        }
        else{
            print("Unable to read the file")
        }
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        outputResult = []
        nutrientRangeValues = []
        outputResultWithDM = []
        
        var temp1 = 0.0
        var temp2 = 0.0
        var temp3 = 0.0
        var temp4 = 0.0
        var temp5 = 0.0
        
        //print("Inside the sending data to json")
        //NSLog("request:\(request)")
        print("The final equation is:",finalEquation)
        if let result = self.webView.stringByEvaluatingJavaScript(from:"addTwoNumbers('\(finalEquation)');"){
            print("The output result is:",result)
            if outputResult.count == 0{
                let outputValuesArray = result.components(separatedBy:",")
                //print(outputValuesArray)
                for value in outputValuesArray {
                    if let number = Double(value) {
                        outputResult.append(number)
                        //print("number: \(number)")
                    }
                }
            
        // Here we will be performing the equation that contains the result page values.
        //print(outputValuesArray.count)
        //print(coefficients.count)
        if outputValuesArray.count == cost.count{
                let nextViewController = self.storyboard!.instantiateViewController(withIdentifier: "resultPage") as! ResultViewController
            //print("the value of count are:", ca.count)
            //print("the value of output count are:", outputResult.count)
            for i in 0..<lbsInRation.count{
                if lbsInRation[i] != 0.0{
                    outputResult[i] = lbsInRation[i]
                }
            }
            
            for i in 0..<sortedIngredientList.count{
                valuesWithDM.append(sortedIngredientList[i].DM/100)
            }
            print(valuesWithDM)
            print(outputResult)
            
            for i in 0..<outputResult.count{
            outputResultWithDM.append(valuesWithDM[i] * outputResult[i])
            }
            print("The value of DM are:",outputResultWithDM)
            
            var outputResultWithDMSum = 0.0
            for i in 0..<outputResultWithDM.count{
            outputResultWithDMSum = outputResultWithDMSum + outputResultWithDM[i]
            }
            
            for i in 0..<outputResultWithDM.count{
                temp1 = temp1 + (outputResultWithDM[i] * ca[i]/outputResultWithDMSum)
            }
            for i in 0..<outputResultWithDM.count{
                temp2 = temp2 + (outputResultWithDM[i] * cp[i]/outputResultWithDMSum)
            }
            for i in 0..<outputResultWithDM.count{
                temp3 = temp3 + (outputResultWithDM[i] * neg[i]/outputResultWithDMSum)
            }
            for i in 0..<outputResultWithDM.count{
                temp4 = temp4 + (outputResultWithDM[i] * nem[i]/outputResultWithDMSum)
            }
            for i in 0..<outputResultWithDM.count{
                temp5 = temp5 + (outputResultWithDM[i] * p[i]/outputResultWithDMSum)
            }
            print(temp1)
            nutrientRangeValues.append(temp1)
            nutrientRangeValues.append(temp2)
            nutrientRangeValues.append(temp5)
            nutrientRangeValues.append(temp3)
            nutrientRangeValues.append(temp4)
            
                nextViewController.outputValues = outputResultWithDM
                nextViewController.outputValueswithDM = outputResultWithDM
                nextViewController.nutrientsType = nutrientsType
                nextViewController.nutrientMinValue = nutrientMinValue
                nextViewController.nutrientMaxValue = nutrientMaxValue
                nextViewController.nutrientRangeValues = nutrientRangeValues
                nextViewController.rationInLbs = outputResult
                self.navigationController?.pushViewController(nextViewController, animated: true)
                }
            }
        }
        else{
            print("There is an error")
        }
        //NSLog("request:\(request)")
       
        return true
    }
    
    
    @IBAction func calculateRation(_ sender: Any) {
        outputResult = []
        cost = []
        lbsInRation = []
        //print("Inside the calculate ration")
        for i in 0 ..< self.tableView.numberOfRows(inSection: 0){
            let cell: RationTableCellDetails = self.tableView.cellForRow(at: IndexPath(row: i, section: 0)) as! RationTableCellDetails
            if cell.costTF.text! == ""{
                count = count + 1;
            }
            if let lbValue = Double(cell.percentageTF.text!){
                self.lbsInRation.append(lbValue)
            }
            else{
                self.lbsInRation.append(0.0)
            }
            if let costValue = Double(cell.costTF.text!){
                    count = 0
                    self.cellValues.append( cell.percentageTF.text!)
                    self.cost.append("\(costValue)")
                    //print("Maximize p=(1/2)x+3y+z+4w subject to\nx+y+z+w<=40\n2x+y-z-w>=10\nw-y>=10")
            }
            else{
                let ac = UIAlertController(title:"Please enter Double values for Cost", message:nil, preferredStyle: .alert)
                let proceedAction = UIAlertAction(title:"OK", style: .default)
                ac.addAction(proceedAction)
                present(ac, animated:true)
            }
            //print("the lbs in ration is:",lbsInRation)
        }
        
        if count>0 {
            calculateButton.isEnabled = true
            let ac = UIAlertController(title:"Cost Fields are mandatory", message:nil, preferredStyle: .alert)
            let proceedAction = UIAlertAction(title:"OK", style: .default)
            ac.addAction(proceedAction)
            present(ac, animated:true)
        }
        else if cost.isEmpty{
            calculateButton.isEnabled = true
            let ac = UIAlertController(title:"Please select atleast one ingredient to proceed forward", message:nil, preferredStyle: .alert)
            let proceedAction = UIAlertAction(title:"OK", style: .default)
            ac.addAction(proceedAction)
            present(ac, animated:true)
        }
        
        else if DetailViewController.selectedIngredients.count >= 2{
            calculateButton.isEnabled = false
            generateCostEquation()
            finalEquation = ""
            generateEquation()
            
            checkingHtmlFile()
            //Checking the result for the obtained output of the algorithm.
//            let nextViewController = self.storyboard!.instantiateViewController(withIdentifier: "resultPage") as! ResultViewController
//           self.navigationController?.pushViewController(nextViewController, animated: true)
        }
        else{
            calculateButton.isEnabled = true
            let ac = UIAlertController(title:"Please select atleast two ingredients to make ration balancing calculation", message:nil, preferredStyle: .alert)
            let proceedAction = UIAlertAction(title:"OK", style: .default)
            ac.addAction(proceedAction)
            present(ac, animated:true)
        }
    }
}
