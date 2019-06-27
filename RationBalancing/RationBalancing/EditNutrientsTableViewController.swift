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
    
    override func viewDidLoad() {
              super.viewDidLoad()

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
//        print("nutrients from nutrients class: \(nutrients)")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    
    override func viewWillAppear(_ animated: Bool) {
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
