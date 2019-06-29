//
//  MasterTableViewController.swift
//  RationBalancing
//
//  Created by student on 6/20/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import UIKit

class MasterTableViewController: UITableViewController {
    var detailViewController: DetailViewController? = nil
    var objects = [Any]()
    var ingredients:[String] = [
        "Corn",
        "Milo",
        "Molasses-Liq Cane",
        "Molasses-Dried Cane",
        "Oats",
        "Rice-Rough",
        "Rice Bran",
        "Wheat"
    ]
    var selectIngredients:[String] = []
    let sections = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    lazy   var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    
    override func viewDidLoad() {
        searchBar.placeholder = "Select Ingredients"
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        super.viewDidLoad()
        //        navigationItem.leftBarButtonItem = editButtonItem
        self.tableView.allowsMultipleSelection = true
        //        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:                 #selector(insertNewObject(_:)))
        //        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                //                controller.selectedIngredients = selectIngredients
                //                print("to Controller=>: \(controller.selectedIngredients)")
                //                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 26
    }
    
    
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [AnyObject]!{
        return self.sections as [AnyObject]
    }
    
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String,
atIndex index: Int) -> Int{
        return index
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        return self.sections[section]
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel!.text = ingredients[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if cell!.isSelected
        {
            cell!.isSelected = false
            if cell!.accessoryType == UITableViewCell.AccessoryType.none
            {
                cell!.accessoryType = UITableViewCell.AccessoryType.checkmark
                if(!DetailViewController.selectedIngredients.contains((cell?.textLabel?.text!)!)){
                    DetailViewController.selectedIngredients.append((cell?.textLabel?.text)!)
                }
            }
            else
            {
                if let index = DetailViewController.selectedIngredients.index(of: (cell?.textLabel?.text)!) {
                    DetailViewController.selectedIngredients.remove(at: index)
                }
                cell!.accessoryType = UITableViewCell.AccessoryType.none
            }
        }
    }

}
