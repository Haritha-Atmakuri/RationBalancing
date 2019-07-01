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
    var ingredients:[String] = ["Corn","Milo","Molasses-Liq Cane","Molasses-Dried Cane","Oats","Rice-Rough","Rice Bran","Wheat"]
    var ingredientsSection = [String]()
    var ingredientsDictionary = [String : [String]]()
    var selectIngredients:[String] = []
  
    lazy   var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    
    override func viewDidLoad() {
        searchBar.placeholder = "Select Ingredients"
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        super.viewDidLoad()
        generateDictionary()
        self.tableView.allowsMultipleSelection = true
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    func generateDictionary(){
        for ingredient in ingredients {
            let key = "\(ingredient[ingredient.startIndex])"
            let lower = key.lowercased()
            if var ingredientValue = ingredientsDictionary[lower]{
                ingredientValue.append(ingredient)
                print(ingredientValue)
            }else{
                ingredientsDictionary[lower] = [ingredient]
            }
        }
        ingredientsSection = [String](ingredientsDictionary.keys)
        ingredientsSection = ingredientsSection.sorted()
        print(ingredientsDictionary)
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
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return ingredientsSection.count
    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return ingredientsSection[section].uppercased()
//    }
    
//    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
//        if let view = view as? UITableViewHeaderFooterView {
//            view.textLabel?.textColor = .white
//        }
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let ingredientKey = ingredientsSection[section]
        if let ingredientValue = ingredientsDictionary[ingredientKey]{
            return ingredientValue.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let ingredientkey = ingredientsSection[indexPath.section]
        if  let ingredientValue = ingredientsDictionary[ingredientkey.lowercased()] {
            cell.textLabel?.text = ingredientValue[indexPath.row]
            cell.textLabel?.textColor = UIColor.black
        }
        return cell
    }
    
//    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return ingredientsSection
//    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        guard let index = ingredientsSection.index(of: title) else {
            return -1
        }
        return index
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




//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return ingredients.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        cell.textLabel!.text = ingredients[indexPath.row]
//        return cell
//    }

