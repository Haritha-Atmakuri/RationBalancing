//
//  InformationViewController.swift
//  RationBalancing
//
//  Created by Student on 10/23/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController {

    var ingredient:Ingredients?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = ingredient?.name
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        // Do any additional setup after loading the view.
    }
    
    @objc func cancel(){
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
