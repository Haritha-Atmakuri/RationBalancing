//
//  FoodStuffModel.swift
//  RationBalancing
//
//  Created by student on 6/24/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import Foundation



struct Ingredient {
    var name:String
    var ca:Double
    var nem:Double
    var neg:Double
    var ee:Double
    var p:Double
}

var feedstuffs = [Ingredient(name: "Corn", ca: 1.0, nem: 2.0, neg: 3.0, ee: 4.0, p: 5.0), Ingredient(name: "Soya", ca: 2.0, nem: 1.0, neg: 0.0, ee: 0.5, p: 1.0)]
