//
//  SecondViewController.swift
//  RationBalancing
//
//  Created by student on 6/20/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import UIKit

class EditNutrientsController: UIViewController {
    var slider : [Nutrients] = [Nutrients(name: "%Ca", minValue: 14.6, maxValue: 18.9),Nutrients(name: "%P", minValue: 5.4, maxValue: 10.2)]
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return slider.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "sliderCell", for: indexPath) as! SliderTableViewCell
//
//        let slider: Nutrients
//        slider = self.slider[indexPath.row]
//
//        cell.nutrientLabel.text = slider.name
//        cell.cellSlider1.maximumValue = slider.minValue
//        cell.cellSlider2.minimumValue = slider.maxValue
//
//        return cell
//    }
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        //Adding Background Image
        let background = UIImage(named: "cattle1")
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = false
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        super.viewDidLoad()
//        tableView.delegate = self
//        tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }


}

