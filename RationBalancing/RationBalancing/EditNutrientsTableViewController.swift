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
//    var nutrients1 : [Nutreints] = []
//    var value1 : String?
//    var value2 : Double?
    override func viewDidLoad() {
        super.viewDidLoad()
//        nutrients1 = []
//        print(value1!)
//        print(value2!)
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        let background = UIImage(named: "cattle1")
        let imageView : UIImageView! = UIImageView(frame: view.bounds)
        imageView.image = background
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
//        imageView.image = background
        imageView.center = view.center
//        view.addSubview(imageView)
        self.tableView.backgroundView = imageView
        
        NutrientsRange.shared.addNutrients()
        nutrients = NutrientsRange.shared.nutrients
//        if value1 != nil && value2 != nil{
//        for i in 0..<nutrients.count{
//            if nutrients[i].cattleWeight == value1! && nutrients[i].growthRequirement == value2!{
//                nutrients1.append(nutrients[i])
//            }
//            }
        }
//        print("nutrients from nutrients class: \(nutrients)")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

    // MARK: - Table view data source

    
    override func viewWillAppear(_ animated: Bool) {
        self.viewDidLoad()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return nutrients.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nutrientValues", for: indexPath) as! EditNutrientsTableViewCell
//        print("in table func: \(nutrients.count)")
        cell.backgroundColor = UIColor(white: 1, alpha: 0.65)
        cell.name.textColor = UIColor.red
        cell.value.textColor = UIColor.red
        cell.name.text = nutrients[indexPath.row].nutrientType
        cell.value.text = "\(String(describing: nutrients[indexPath.row].value))"
        // Configure the cell...

        return cell
    }

}
