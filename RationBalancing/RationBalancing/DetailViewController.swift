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
    
    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DetailViewController.selectedIngredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedIngredients", for: indexPath)
        cell.textLabel!.text = DetailViewController.selectedIngredients[indexPath.row]
        return cell
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


}
