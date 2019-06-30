//
//  CheckingTableViewController.swift
//  RationBalancing
//
//  Created by student on 6/29/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import UIKit

class CheckingTableViewController: UITableViewController {
    
    var contactArray = ["Alan Douglas", "Bob", "Bethany Webster", "Casey Fleser", "Daniel Huckaby", "Michael Morrison"]
    var contactSection = [String]()
    var contactDictionary = [String : [String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateWordsDict()
        let nav = self.navigationController?.navigationBar
        nav?.tintColor = UIColor(red: 16.0, green: 18.0, blue: 34.0, alpha: 1.0)
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.tableView.sectionIndexBackgroundColor = .black
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func generateWordsDict(){
        for contact in contactArray {
            
            let key = "\(contact[contact.startIndex])"
            let lower = key.lowercased()
            
            if var contactValue = contactDictionary[lower]
            {
                contactValue.append(contact)
            }else{
                contactDictionary[lower] = [contact]
            }
        }
        contactSection = [String](contactDictionary.keys)
        contactSection = contactSection.sorted()
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return contactSection.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return contactSection[section].uppercased()
    }
    
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if let view = view as? UITableViewHeaderFooterView {
            view.textLabel?.textColor = .white
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let contactKey = contactSection[section]
        if let contactValue = contactDictionary[contactKey]{
            return contactValue.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "check", for: indexPath)
        let cotactkey = contactSection[indexPath.section]
        if  let contactValue = contactDictionary[cotactkey.lowercased()] {
            cell.textLabel?.text = contactValue[indexPath.row]
            cell.textLabel?.textColor = UIColor.black
        }
        return cell
    }
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return contactSection
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        guard let index = contactSection.index(of: title) else {
            return -1
        }
        return index
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }

//    struct Section {
//        let letter : String
//        let names : [String]
//    }
//
//    let usernames = ["Corn",
//                     "Milo",
//                     "Molasses-Liq Cane",
//                     "Molasses-Dried Cane",
//                     "Oats",
//                     "Rice-Rough",
//                     "Rice Bran",
//                     "Wheat"]
//
//    var sections = [Section]()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // group the array to ["N": ["Nancy"], "S": ["Sue", "Sam"], "J": ["John", "James", "Jenna"], "E": ["Eric"]]
//        let groupedDictionary = Dictionary(grouping: usernames, by: {String($0.prefix(1))})
//        // get the keys and sort them
//        let keys = groupedDictionary.keys.sorted()
//        // map the sorted keys to a struct
//        sections = keys.map{ Section(letter: $0, names: groupedDictionary[$0]!.sorted()) }
//        self.tableView.reloadData()
//    }
//
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cellID = "check"
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
//        let section = sections[indexPath.section]
//        let username = section.names[indexPath.row]
//        cell.textLabel?.text = username
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return sections[section].names.count
//    }
//
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
//        return sections.count
//    }
//
//    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return sections.map{$0.letter}
//    }
//
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return sections[section].letter
//    }


}
