//
//  FoodStuffModel.swift
//  RationBalancing
//
//  Created by student on 6/24/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import Foundation

class NutrientsRange{

    static var shared = NutrientsRange()
    
    var nutrients:[Nutreints] = []
    
    func addNutrients(){
        
        //        nutrients.append(Nutreints.init(cattleWeight: "440lb", growthRequirement: 1.1 , nutrientType: "NEg", value: 1.27))
        
        nutrients = [Nutreints.init(cattleWeight: "440", growthRequirement: 1.1 , nutrientType: "NEg", minvalue: 1.27, maxvalue: 12.00),Nutreints.init(cattleWeight: "440", growthRequirement: 2.2 , nutrientType: "NEg", minvalue: 2.72,maxvalue: 12.00),Nutreints.init(cattleWeight: "440", growthRequirement: 3.3, nutrientType: "NEg", minvalue: 4.24,maxvalue: 12.00),Nutreints.init(cattleWeight: "440", growthRequirement: 4.4, nutrientType: "NEg", minvalue: 5.81,maxvalue: 12.00),
                     Nutreints.init(cattleWeight: "440", growthRequirement: 1.1 , nutrientType: "Ca", minvalue: 14,maxvalue: 12.00),Nutreints.init(cattleWeight: "440", growthRequirement: 2.2 , nutrientType: "Ca", minvalue: 27,maxvalue: 12.00),Nutreints.init(cattleWeight: "440", growthRequirement: 3.3, nutrientType: "Ca", minvalue: 39,maxvalue: 12.00),Nutreints.init(cattleWeight: "440", growthRequirement: 4.4, nutrientType: "Ca", minvalue: 52,maxvalue: 12.00),
                     Nutreints.init(cattleWeight: "440", growthRequirement: 1.1 , nutrientType: "P", minvalue: 6,maxvalue: 12.00),Nutreints.init(cattleWeight: "440", growthRequirement: 2.2 , nutrientType: "P", minvalue: 11,maxvalue: 12.00),Nutreints.init(cattleWeight: "440", growthRequirement: 3.3, nutrientType: "P", minvalue: 16,maxvalue: 12.00),Nutreints.init(cattleWeight: "440", growthRequirement: 4.4, nutrientType: "P", minvalue: 21,maxvalue: 12.00),
                     Nutreints.init(cattleWeight: "440", growthRequirement: 1.1 , nutrientType: "NEm", minvalue: 14,maxvalue: 12.00),Nutreints.init(cattleWeight: "440", growthRequirement: 2.2 , nutrientType: "NEm", minvalue: 27,maxvalue: 12.00),Nutreints.init(cattleWeight: "440", growthRequirement: 3.3, nutrientType: "NEm", minvalue: 39,maxvalue: 12.00),Nutreints.init(cattleWeight: "440", growthRequirement: 4.4, nutrientType: "NEm", minvalue: 52,maxvalue: 12.00)]

    }
}


struct Nutreints {
    static var shared = Nutreints()
    var cattleWeight:String
    var growthRequirement:Double
    var nutrientType:String
    var minvalue:Float
    var maxvalue:Float
    init(){
        self.init(cattleWeight: "", growthRequirement: 0.0, nutrientType: "", minvalue: 0.0,maxvalue: 0.0)
    }
    
    init(cattleWeight:String,growthRequirement:Double,nutrientType:String,minvalue:Float,maxvalue:Float){
        self.cattleWeight = cattleWeight
        self.growthRequirement = growthRequirement
        self.nutrientType = nutrientType
        self.minvalue = minvalue
        self.maxvalue = maxvalue
    }
}


struct Ingredient {
    var feedstuff:String
    var dm:Double
    var tdn:Double
    var cp:Double
    var uip:Double
    var cf:Double
    var adf:Double
    var ndf:Double
    var endf:Double
    var ee:Double
    var ash:Double
    var ca:Double
    var p:Double
    var k:Double
    var ci:Double
    var s:Double
    var NEm:Double
    var NEg:Double
    var NEi:Double
    var Zn:Double
    
}

//var feedstuffs = [Ingredient(name: "Corn", ca: 1.0, nem: 2.0, neg: 3.0, ee: 4.0, p: 5.0), Ingredient(name: "Soya", ca: 2.0, nem: 1.0, neg: 0.0, ee: 0.5, p: 1.0)]
