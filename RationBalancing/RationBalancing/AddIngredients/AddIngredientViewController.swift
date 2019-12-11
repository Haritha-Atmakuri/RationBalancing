//
//  AddIngredientViewController.swift
//  RationBalancing
//
//  Created by Student on 9/30/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import UIKit

class AddIngredientViewController: UIViewController, UITextFieldDelegate {

    static var count = 0
    
    @IBOutlet weak var _idLBL: UILabel!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var dmTF: UITextField!
    @IBOutlet weak var tdmTF: UITextField!
    @IBOutlet weak var nemTF: UITextField!
    @IBOutlet weak var negTF: UITextField!
    @IBOutlet weak var neiTF: UITextField!
    @IBOutlet weak var cpTF: UITextField!
    @IBOutlet weak var uipTF: UITextField!
    @IBOutlet weak var cfTF: UITextField!
    @IBOutlet weak var adfTF: UITextField!
    @IBOutlet weak var ndfTF: UITextField!
    @IBOutlet weak var endfTF: UITextField!
    @IBOutlet weak var eeTF: UITextField!
    @IBOutlet weak var ashTF: UITextField!
    @IBOutlet weak var caTF: UITextField!
    @IBOutlet weak var pTF: UITextField!
    @IBOutlet weak var kTF: UITextField!
    @IBOutlet weak var ciTF: UITextField!
    @IBOutlet weak var sTF: UITextField!
    @IBOutlet weak var znppmTF: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        AppUtility.lockOrientation(.portrait)
        AddIngredientViewController.count = 0
        viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        AppUtility.lockOrientation(.all)
    }
    
    var passCode = "Gdp2019"
    
    override func viewDidLoad() {
        AppUtility.lockOrientation(.portrait)
        AddIngredientViewController.count = 0
        super.viewDidLoad()
        let ac = UIAlertController(title:"Enter Passcode to proceed further", message:nil, preferredStyle: .alert)
         let ac1 = UIAlertController(title:"Invalid Password", message:nil, preferredStyle: .alert)
        ac.addTextField(configurationHandler:nil)
        ac.textFields?[0].isSecureTextEntry = true
        let setTaxAction = UIAlertAction(title:"OK", style: .default)
        {(aia)->Void in
            if ac.textFields?[0].text == self.passCode{
                print("Inside sucess")
                self.createAddIngredientsPage()
            }
            else{
                self.viewDidLoad()
            }
        }
        let cancelAction = UIAlertAction(title:"Cancel", style: .cancel){(aia)->Void in
            self.tabBarController?.selectedIndex = 1
        }
        ac.addAction(setTaxAction)
        ac.addAction(cancelAction)
        present(ac, animated:true)
        
        present(ac1, animated:true)
    }
    
    func createAddIngredientsPage(){
        nameTF.delegate = self
        nemTF.delegate = self
        negTF.delegate = self
        caTF.delegate = self
        pTF.delegate = self
        cpTF.delegate = self
        
        nameTF.backgroundColor = UIColor.lightGray
        nemTF.backgroundColor = UIColor.lightGray
        negTF.backgroundColor = UIColor.lightGray
        caTF.backgroundColor = UIColor.lightGray
        pTF.backgroundColor = UIColor.lightGray
        cpTF.backgroundColor = UIColor.lightGray

        Ingreed.shared.retrieveLastIngridient()
        _idLBL.text = String(Int(Ingreed.shared.lastIngredients._id)! + 1)
        nameTF.text = ""
        nemTF.text = ""
        negTF.text = ""
        caTF.text = ""
        pTF.text = ""
        cpTF.text = ""
        dmTF.text = String(0.0)
        tdmTF.text = String(0.0)
        neiTF.text = String(0.0)
        uipTF.text = String(0.0)
        cfTF.text = String(0.0)
        adfTF.text = String(0.0)
        ndfTF.text = String(0.0)
        endfTF.text = String(0.0)
        eeTF.text = String(0.0)
        ashTF.text = String(0.0)
        kTF.text = String(0.0)
        ciTF.text = String(0.0)
        sTF.text = String(0.0)
        znppmTF.text = String(0.0)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField{
        case nameTF:
            nameTF.backgroundColor = UIColor.lightGray
        case nemTF:
            nemTF.backgroundColor = UIColor.lightGray
        case negTF:
            negTF.backgroundColor = UIColor.lightGray
        case caTF:
            caTF.backgroundColor = UIColor.lightGray
        case pTF:
            pTF.backgroundColor = UIColor.lightGray
        case cpTF:
            cpTF.backgroundColor = UIColor.lightGray
        default:
           print("Do nothing")
        }
    }
    
    
    
    
    @IBAction func save(_ sender: Any) {
        nameTF.backgroundColor = UIColor.lightGray
        nemTF.backgroundColor = UIColor.lightGray
        negTF.backgroundColor = UIColor.lightGray
        caTF.backgroundColor = UIColor.lightGray
        pTF.backgroundColor = UIColor.lightGray
        cpTF.backgroundColor = UIColor.lightGray
        print("Inside save")
        if let name = nameTF.text,let nem = Double(nemTF.text!),let neg = Double(negTF.text!),let ca = Double(caTF.text!),let p = Double(pTF.text!), let cp = Double(cpTF.text!){
            if nem > 0.0 && neg > 0.0 && ca > 0.0 && p > 0.0 && cp > 0.0{
                let ing = Ingredients(_id: _idLBL.text!, name: name, DM: Double(dmTF.text!)!, TDM: Double(tdmTF.text!)!, NEm: nem, NEg: neg, NEi: Double(neiTF.text!)!, CP: Double(cpTF.text!)!, UIP: Double(uipTF.text!)!, CF: Double(cfTF.text!)!, ADF: Double(adfTF.text!)!, NDF: Double(ndfTF.text!)!, eNDF: Double(endfTF.text!)!, EE: Double(eeTF.text!)!, Ash: Double(ashTF.text!)!, Ca: ca, P: p, K: Double(kTF.text!)!, CI: Double(ciTF.text!)!, S: Double(sTF.text!)!, Znppm: Double(znppmTF.text!)!)
            Ingreed.shared.saveIngredient(ingredient: ing)
            createAddIngredientsPage()
            AddIngredientViewController.count = AddIngredientViewController.count + 1
                
                let splitViewController = self.tabBarController?.viewControllers![2] as? UISplitViewController
                let navigationController = splitViewController!.viewControllers.first as? UINavigationController
                let master = navigationController?.viewControllers.first as! MasterTableViewController
                 master.reloadMasterTableViewData()
                
            self.tabBarController?.selectedIndex = 2
            print("Saved Sucessfully")
            
                
            }
            else if name < ""{
                nameTF.backgroundColor = UIColor.red
                nemTF.backgroundColor = UIColor.lightGray
                negTF.backgroundColor = UIColor.lightGray
                caTF.backgroundColor = UIColor.lightGray
                pTF.backgroundColor = UIColor.lightGray
                cpTF.backgroundColor = UIColor.lightGray
                let ac = UIAlertController(title:"Invalid name", message:nil, preferredStyle: .alert)
                let proceedAction = UIAlertAction(title:"OK", style: .default)
                ac.addAction(proceedAction)
                present(ac, animated:true)
            }
            else if nem<0{
               nemTF.backgroundColor = UIColor.red
                nameTF.backgroundColor = UIColor.lightGray
                negTF.backgroundColor = UIColor.lightGray
                caTF.backgroundColor = UIColor.lightGray
                pTF.backgroundColor = UIColor.lightGray
                cpTF.backgroundColor = UIColor.lightGray
                let ac = UIAlertController(title:"Invalid nem", message:nil, preferredStyle: .alert)
                let proceedAction = UIAlertAction(title:"OK", style: .default)
                ac.addAction(proceedAction)
                present(ac, animated:true)
            }
            else if neg<0{
                negTF.backgroundColor = UIColor.red
                nameTF.backgroundColor = UIColor.lightGray
                nemTF.backgroundColor = UIColor.lightGray
                caTF.backgroundColor = UIColor.lightGray
                pTF.backgroundColor = UIColor.lightGray
                cpTF.backgroundColor = UIColor.lightGray
                let ac = UIAlertController(title:"Invalid neg", message:nil, preferredStyle: .alert)
                let proceedAction = UIAlertAction(title:"OK", style: .default)
                ac.addAction(proceedAction)
                present(ac, animated:true)
            }
            else if ca<0{
                caTF.backgroundColor = UIColor.red
                nameTF.backgroundColor = UIColor.lightGray
                nemTF.backgroundColor = UIColor.lightGray
                negTF.backgroundColor = UIColor.lightGray
                pTF.backgroundColor = UIColor.lightGray
                cpTF.backgroundColor = UIColor.lightGray
                let ac = UIAlertController(title:"Invalid ca", message:nil, preferredStyle: .alert)
                let proceedAction = UIAlertAction(title:"OK", style: .default)
                ac.addAction(proceedAction)
                present(ac, animated:true)
            }
            else if p<0{
                pTF.backgroundColor = UIColor.red
                nameTF.backgroundColor = UIColor.lightGray
                nemTF.backgroundColor = UIColor.lightGray
                negTF.backgroundColor = UIColor.lightGray
                caTF.backgroundColor = UIColor.lightGray
                cpTF.backgroundColor = UIColor.lightGray
                let ac = UIAlertController(title:"Invalid p", message:nil, preferredStyle: .alert)
                let proceedAction = UIAlertAction(title:"OK", style: .default)
                ac.addAction(proceedAction)
                present(ac, animated:true)
            }
            else if cp<0{
                cpTF.backgroundColor = UIColor.red
                nameTF.backgroundColor = UIColor.lightGray
                nemTF.backgroundColor = UIColor.lightGray
                negTF.backgroundColor = UIColor.lightGray
                caTF.backgroundColor = UIColor.lightGray
                pTF.backgroundColor = UIColor.lightGray
                
                let ac = UIAlertController(title:"Invalid cp", message:nil, preferredStyle: .alert)
                let proceedAction = UIAlertAction(title:"OK", style: .default)
                ac.addAction(proceedAction)
                present(ac, animated:true)
            }
        }
        else if nameTF == nil || nameTF.text! == ""{
            nameTF.backgroundColor = UIColor.red
            nemTF.backgroundColor = UIColor.lightGray
            negTF.backgroundColor = UIColor.lightGray
            caTF.backgroundColor = UIColor.lightGray
            pTF.backgroundColor = UIColor.lightGray
            cpTF.backgroundColor = UIColor.lightGray
        }
        else if nemTF == nil || nemTF.text == ""{
            nameTF.backgroundColor = UIColor.lightGray
            nemTF.backgroundColor = UIColor.red
            negTF.backgroundColor = UIColor.lightGray
            caTF.backgroundColor = UIColor.lightGray
            pTF.backgroundColor = UIColor.lightGray
            cpTF.backgroundColor = UIColor.lightGray
        }
        else if negTF == nil || negTF.text! == ""{
            nameTF.backgroundColor = UIColor.lightGray
            nemTF.backgroundColor = UIColor.lightGray
            negTF.backgroundColor = UIColor.red
            caTF.backgroundColor = UIColor.lightGray
            pTF.backgroundColor = UIColor.lightGray
            cpTF.backgroundColor = UIColor.lightGray
        }
        else if caTF == nil || caTF.text == ""{
            nameTF.backgroundColor = UIColor.lightGray
            nemTF.backgroundColor = UIColor.lightGray
            negTF.backgroundColor = UIColor.lightGray
            caTF.backgroundColor = UIColor.red
            pTF.backgroundColor = UIColor.lightGray
            cpTF.backgroundColor = UIColor.lightGray
        }
        else if pTF == nil || pTF.text == ""{
            nameTF.backgroundColor = UIColor.lightGray
            nemTF.backgroundColor = UIColor.lightGray
            negTF.backgroundColor = UIColor.lightGray
            caTF.backgroundColor = UIColor.lightGray
            pTF.backgroundColor = UIColor.red
            cpTF.backgroundColor = UIColor.lightGray
        }
        else if cpTF == nil || cpTF.text == ""{
            nameTF.backgroundColor = UIColor.lightGray
            nemTF.backgroundColor = UIColor.lightGray
            negTF.backgroundColor = UIColor.lightGray
            caTF.backgroundColor = UIColor.lightGray
            pTF.backgroundColor = UIColor.lightGray
            cpTF.backgroundColor = UIColor.red
        }
        else{
            let ac = UIAlertController(title:"Please fill all the mandatory details", message:nil, preferredStyle: .alert)
            nameTF.backgroundColor = UIColor.red
            nemTF.backgroundColor = UIColor.red
            negTF.backgroundColor = UIColor.red
            caTF.backgroundColor = UIColor.red
            pTF.backgroundColor = UIColor.red
            cpTF.backgroundColor = UIColor.red
            
            let proceedAction = UIAlertAction(title:"OK", style: .default)
            ac.addAction(proceedAction)
            present(ac, animated:true)
        }
    }

}
