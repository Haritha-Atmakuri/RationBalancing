//
//  DetailViewController.swift
//  RationBalancing
//
//  Created by student on 6/20/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    static var selectedIngredients:[String] = []
    var rationValues:[Double] = []
    var cellValues:[String] = []
    @IBOutlet weak var tableView: UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int)-> String? {
        return ["SELECTED INGREDIENTS", "RESULT"][section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
        return DetailViewController.selectedIngredients.count
        }
        else{
            return DetailViewController.selectedIngredients.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedIngredients", for: indexPath) as! RationTableCellDetails
        cell.textLabel!.text = DetailViewController.selectedIngredients[indexPath.row]
        return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Result", for: indexPath)
            return cell
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(DetailViewController.selectedIngredients.count)
        tableView.reloadData()
    }


    @IBAction func calculateRation(_ sender: Any) {
//        let indexPath = IndexPath(row: 0, section: 0)
//        let cell = tableView.cellForRow(at: indexPath)
//        print("The value is:",cell?.textLabel?.text! ?? "No input")
        for i in 0 ..< self.tableView.numberOfRows(inSection: 0){
            let cell: RationTableCellDetails = self.tableView.cellForRow(at: IndexPath(row: i, section: 0)) as! RationTableCellDetails
            self.cellValues.append( cell.inputTF.text! )

        }
        print(cellValues)
    }
}