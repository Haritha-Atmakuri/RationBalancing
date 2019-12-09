//
//  MasterTableViewController.swift
//  RationBalancing
//
//  Created by student on 6/20/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import UIKit


class MasterTableViewController: UITableViewController, UISearchBarDelegate, UIGestureRecognizerDelegate {
    var searchIngredient:[String] = []
    var searching = false
    
    var cattleWeight : String?
    var growthrequirement : String?
    
    var ingredientsList:[Ingredients] = []
    var ingredients:[String] = []
    
    var detailViewController: DetailViewController? = nil
    
    var objects = [Any]()
    var ingredientsSection = [String]()
    var ingredientsDictionary = [String : [String]]()
    
    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 250, height: 200))

    override func viewDidLoad() {
        
        //Loading Data From JSON FIle
        ingredientsList = []
        ingredients = []
        
        ingredientsList = Ingreed.shared.allIngredients
        for i in ingredientsList{
            ingredients.append(i.name)
        }
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
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
        
        //Adding Gesture
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPressGesture.minimumPressDuration = 0.5
        longPressGesture.delegate = self
        self.tableView.addGestureRecognizer(longPressGesture)
        
    }
    
    //Here is the method that handles the gesture movements.
    @objc func handleLongPress(longPressGesture: UILongPressGestureRecognizer) {
        let p = longPressGesture.location(in: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: p)
        if indexPath == nil {
            //print("Long press on table view, not row.")
        } else if longPressGesture.state == UIGestureRecognizer.State.began {
            //print("Long press on row, at \(indexPath!.row)")
            let transition:CATransition = CATransition()
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromBottom
            let infoNavCan = storyboard?.instantiateViewController(withIdentifier: "informationVC") as! UINavigationController
            (infoNavCan.topViewController as! InformationViewController).ingredient = ingredientsList[(indexPath?.row)!]
            infoNavCan.view.layer.add(transition, forKey: kCATransition)
            self.present(infoNavCan, animated: true, completion: nil)
        }
    }
    
    func reloadMasterTableViewData(){
       tableView.reloadData()
    }
    
    func generateDictionary(){
//        if searching == true{
//            for ingredient in searchIngredient {
//                let key = "\(ingredient[ingredient.startIndex])"
//                let lower = key.lowercased()
//                if var ingredientValue = ingredientsDictionary[lower]{
//                    ingredientValue.append(ingredient)
//                    ingredientsDictionary[lower] = ingredientValue
//                }else{
//                    ingredientsDictionary[lower] = [ingredient]
//                    //                print(ingredientsDictionary)
//                }
//            }
//        }
//        else{
        for ingredient in ingredients {
            let key = "\(ingredient[ingredient.startIndex])"
            let lower = key.lowercased()
            if var ingredientValue = ingredientsDictionary[lower]{
                ingredientValue.append(ingredient)
                ingredientsDictionary[lower] = ingredientValue
            }else{
                ingredientsDictionary[lower] = [ingredient]
                //print(ingredientsDictionary)
            }
        }
        
//    }
        ingredientsSection = [String](ingredientsDictionary.keys)
        ingredientsSection = ingredientsSection.sorted()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Inside view will appear")
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        //print("Inside view will appear of Master view controller")
        //print("The value of the count of add ingredient is",AddIngredientViewController.count)
        if AddIngredientViewController.count != 0{
            //print("Inside this function of view will appear")
            ingredientsList = []
            ingredients = []
            Ingreed.shared.retreiveAllIngredients()
            ingredientsList = Ingreed.shared.allIngredients
            for i in ingredientsList{
                ingredients.append(i.name)
            }
            generateDictionary()
        }
        tableView.reloadData()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        print("Inside view did appear")
         if AddIngredientViewController.count != 0{
        tableView.reloadData()
        }
        tableView.reloadData()
    }
   
    @IBAction func advancedSearch(_ sender: Any) {
        let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let aboutViewController = mainStoryboard.instantiateViewController(withIdentifier: "search") as! AdvancedSearchViewController
        aboutViewController.modalPresentationStyle = .overCurrentContext
        self.present(aboutViewController, animated: true, completion: nil)
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
        if segue.identifier == "search"{
            let aboutViewController = segue.destination as! AdvancedSearchViewController
            aboutViewController.ingredients = self.ingredients
        }
    }
    
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        //searchActive = true
//        searching = true
//    }
//
//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        //searchActive = false
//        searching = false
//    }
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        //searchActive = false
//        searching = false
//    }

     func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchIngredient = ingredients.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        //print(searchIngredient)
        //generateDictionary()
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if searching == true{
            return 1
        }
        else{
        return ingredientsSection.count
        }
    }

//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if searching == true{
//            return String(searchIngredient[0].first!)
//        }
//        else{
//        return ingredientsSection[section].uppercased()
//        }
//    }

    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if let view = view as? UITableViewHeaderFooterView {
            view.textLabel?.textColor = .white
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching == true{
            return searchIngredient.count
        }
        else{
        let ingredientKey = ingredientsSection[section]
        if let ingredientValue = ingredientsDictionary[ingredientKey]{
            return ingredientValue.count
        }
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! IngredientsTableViewCell

        if searching == true{
            cell.textLabel?.text = searchIngredient[indexPath.row]
        }
        else{
        let ingredientkey = ingredientsSection[indexPath.section]
        if  let ingredientValue = ingredientsDictionary[ingredientkey.lowercased()] {
            cell.textLabel?.text = ingredientValue[indexPath.row]
            cell.textLabel?.textColor = UIColor.black
        }
      }
        if DetailViewController.selectedIngredients.contains((cell.textLabel?.text)!){
            cell.accessoryType = .checkmark
        }
        else{
            cell.accessoryType = .none
        }
        return cell
    }
    
//    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return ingredientsSection
//    }
//
//    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
//        guard let index = ingredientsSection.index(of: title) else {
//            return -1
//        }
//        return index
//    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            if cell.accessoryType == .checkmark {
                if let index = DetailViewController.selectedIngredients.index(of: (cell.textLabel?.text)!) {
                                DetailViewController.selectedIngredients.remove(at: index)
                          }
                cell.accessoryType = .none
                cell.isHighlighted = false
            } else {
                if(!DetailViewController.selectedIngredients.contains((cell.textLabel?.text!)!)){
                    DetailViewController.selectedIngredients.append((cell.textLabel?.text)!)
                                }
                cell.accessoryType = .checkmark
                cell.isHighlighted = true
            }
        }
    }
}


