//
//  AdvancedSearchViewController.swift
//  RationBalancing
//
//  Created by Student on 9/26/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import UIKit

class AdvancedSearchViewController: UIViewController,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var searchActive : Bool = false
    
    var searchIngredient:[String] = []
    var searching = false

    var ingredients:[String] = []
    var alphabeticalIngredients:[String] = []
    
    var detailViewController: DetailViewController? = nil
    
    var objects = [Any]()
    var ingredientsSection = [String]()
    var ingredientsDictionary = [String : [String]]()
    var selectIngredients:[String] = []
    
    override func viewDidLoad() {
        
        //print("Inside the view did load and count of it",ingredients.count)
        //generateDictionary()
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        searchBar.placeholder = "Select Ingredients"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationItem.title = "Search Ingredients"
        
        super.viewDidLoad()
        self.tableView.allowsMultipleSelection = true
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //searchActive = true
        searching = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        //searchActive = false
        searching = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
       // searchActive = false;
        searching = false
        searchBar.text = nil
        searchBar.resignFirstResponder()
        tableView.resignFirstResponder()
        self.searchBar.showsCancelButton = false
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //searchActive = false
        searching = false
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //self.searchActive = true;
        self.searchBar.showsCancelButton = true
        searchIngredient = []
        searchIngredient = alphabeticalIngredients.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tableView.reloadData()
    }
    
     func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        searchBar.resignFirstResponder()
        searchBar.endEditing(true)
        self.view.endEditing(true)
        self.searchBar.showsCancelButton = false
        self.searchBar.text=""
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("Inside did select row",indexPath)
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
    
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching == true{
            return searchIngredient.count
        }
        else{
            return alphabeticalIngredients.count
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "advancedshowDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "advanceSearch", for: indexPath)
//        print(alphabeticalIngredients)
        if searching == true{
            //print("Inside searching")
            //searching = false
            cell.textLabel?.text = searchIngredient[indexPath.row]
        }
        else{
            //print("Inside non searching",indexPath)
                cell.textLabel?.text = alphabeticalIngredients[indexPath.row]
                cell.textLabel?.textColor = UIColor.black
        }
        if DetailViewController.selectedIngredients.contains((cell.textLabel?.text)!){
            cell.accessoryType = .checkmark
        }
        else{
            cell.accessoryType = .none
        }
        return cell
    }


    
    @IBAction func A(_ sender: Any) {
        alphabeticalIngredients = []
        for i in ingredients{
            if i[i.startIndex] == "A"{
               alphabeticalIngredients.append(i)
            }
        }
        self.tableView.reloadData()
        print(alphabeticalIngredients.count)
    }
    
    @IBAction func B(_ sender: Any) {
        alphabeticalIngredients = []
        for i in ingredients{
            if i[i.startIndex] == "B"{
                alphabeticalIngredients.append(i)
            }
        }
        self.tableView.reloadData()
        print(alphabeticalIngredients.count)
    }
    
    @IBAction func C(_ sender: Any) {
        alphabeticalIngredients = []
        for i in ingredients{
            if i[i.startIndex] == "C"{
                alphabeticalIngredients.append(i)
            }
        }
        self.tableView.reloadData()
        print(alphabeticalIngredients.count)
    }
    
    @IBAction func DtoF(_ sender: Any) {
        alphabeticalIngredients = []
        for i in ingredients{
            if i[i.startIndex] == "D" || i[i.startIndex] == "E"
            || i[i.startIndex] == "F"{
                alphabeticalIngredients.append(i)
            }
        }
        self.tableView.reloadData()
        print(alphabeticalIngredients.count)
    }
    
    @IBAction func GtoL(_ sender: Any) {
        alphabeticalIngredients = []
        for i in ingredients{
            if i[i.startIndex] == "G" || i[i.startIndex] == "H" ||
                i[i.startIndex] == "I" ||
                i[i.startIndex] == "J" ||
                i[i.startIndex] == "K" ||
                i[i.startIndex] == "L"{
                alphabeticalIngredients.append(i)
            }
        }
        self.tableView.reloadData()
        print(alphabeticalIngredients.count)
    }
    
    @IBAction func MtoN(_ sender: Any) {
        alphabeticalIngredients = []
        for i in ingredients{
            if i[i.startIndex] == "M" ||
                i[i.startIndex] == "N"{
                alphabeticalIngredients.append(i)
            }
        }
        self.tableView.reloadData()
        print(alphabeticalIngredients.count)
    }
    
    @IBAction func O(_ sender: Any) {
        alphabeticalIngredients = []
        for i in ingredients{
            if i[i.startIndex] == "O"{
                alphabeticalIngredients.append(i)
            }
        }
        self.tableView.reloadData()
        print(alphabeticalIngredients.count)
    }
    
    @IBAction func P(_ sender: Any) {
        alphabeticalIngredients = []
        for i in ingredients{
            if i[i.startIndex] == "P"{
                alphabeticalIngredients.append(i)
            }
        }
        self.tableView.reloadData()
        print(alphabeticalIngredients.count)
    }
    
    
    @IBAction func QtoaS(_ sender: Any) {
        alphabeticalIngredients = []
        for i in ingredients{
            if i[i.startIndex] == "Q" || i[i.startIndex] == "R" || i[i.startIndex] == "S"{
                alphabeticalIngredients.append(i)
            }
        }
        self.tableView.reloadData()
        print(alphabeticalIngredients.count)
    }
    
    
    
    @IBAction func TtoZ(_ sender: Any) {
        alphabeticalIngredients = []
        for i in ingredients{
            if i[i.startIndex] == "T" || i[i.startIndex] == "U" || i[i.startIndex] == "V" || i[i.startIndex] == "W" ||
                i[i.startIndex] == "X" ||
                i[i.startIndex] == "Y" ||
                i[i.startIndex] == "Z"{
                alphabeticalIngredients.append(i)
            }
        }
        self.tableView.reloadData()
        print(alphabeticalIngredients.count)
    }
}
    


