//
//  HelpViewController.swift
//  RationBalancing
//
//  Created by student on 6/22/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {

    @IBOutlet weak var HelpTextView: UITextView!
    override func viewDidLoad() {
        let shownString = NSMutableAttributedString(string: "Please  click  here to know more on calculations of Ration Balancing")
        let url = URL(string: "http://www.ansc.purdue.edu/compute/balance.htm")!

        // Set the 'click here' substring to be the link
        shownString.setAttributes([.link: url], range: NSMakeRange(7, 12))

        HelpTextView.attributedText = shownString
        HelpTextView.isUserInteractionEnabled = true
        HelpTextView.isEditable = false

        // Set how links should appear: blue and underlined
        HelpTextView.linkTextAttributes = [
            .foregroundColor: UIColor.blue,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        super.viewDidLoad()
        let background = UIImage(named: "cattle1")
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        // Do any additional setup after loading the view.
    }

}
