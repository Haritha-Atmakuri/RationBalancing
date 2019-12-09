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
        
        nutrients = [Nutreints.init(cattleWeight: "450-550lbs", growthRequirement: "1.1lbs" , nutrientType: "NEg", minvalue: 1.27, maxvalue: 3.00),Nutreints.init(cattleWeight: "450-550lbs", growthRequirement: "2.2lbs" , nutrientType: "NEg", minvalue: 2.72,maxvalue: 4.00),Nutreints.init(cattleWeight: "450-550lbs", growthRequirement: "3.3lbs", nutrientType: "NEg", minvalue: 4.24,maxvalue: 8.00),Nutreints.init(cattleWeight: "450-550lbs", growthRequirement: "4.4lbs", nutrientType: "NEg", minvalue: 5.81,maxvalue: 8.80),
                Nutreints.init(cattleWeight: "450-550lbs", growthRequirement: "1.1lbs" , nutrientType: "Ca", minvalue: 14,maxvalue: 20.00),Nutreints.init(cattleWeight: "450-550lbs", growthRequirement: "2.2lbs" , nutrientType: "Ca", minvalue: 27,maxvalue: 22.00),Nutreints.init(cattleWeight: "450-550lbs", growthRequirement: "3.3lbs", nutrientType: "Ca", minvalue: 39,maxvalue: 22.00),Nutreints.init(cattleWeight: "450-550lbs", growthRequirement: "4.4lbs", nutrientType: "Ca", minvalue: 52,maxvalue: 22.00),
                Nutreints.init(cattleWeight: "450-550lbs", growthRequirement: "1.1lbs" , nutrientType: "P", minvalue: 6.00,maxvalue: 9.00),Nutreints.init(cattleWeight: "450-550lbs", growthRequirement: "2.2lbs" , nutrientType: "P", minvalue: 11,maxvalue: 22.00),Nutreints.init(cattleWeight: "450-550lbs", growthRequirement: "3.3lbs", nutrientType: "P", minvalue: 16,maxvalue: 22.00),Nutreints.init(cattleWeight: "450-550lbs", growthRequirement: "4.4lbs", nutrientType: "P", minvalue: 21,maxvalue: 22.00),
                Nutreints.init(cattleWeight: "450-550lbs", growthRequirement: "1.1lbs" , nutrientType: "NEm", minvalue: 14,maxvalue: 18.00),Nutreints.init(cattleWeight: "450-550lbs", growthRequirement: "2.2lbs" , nutrientType: "NEm", minvalue: 27,maxvalue: 22.00),Nutreints.init(cattleWeight: "450-550lbs", growthRequirement: "3.3lbs", nutrientType: "NEm", minvalue: 39,maxvalue: 22.00),Nutreints.init(cattleWeight: "450-550lbs", growthRequirement: "4.4lbs", nutrientType: "NEm", minvalue: 52,maxvalue: 22.00)]

    }
}


struct Nutreints {
    static var shared = Nutreints()
    var cattleWeight:String
    var growthRequirement:String
    var nutrientType:String
    var minvalue:Float
    var maxvalue:Float
    init(){
        self.init(cattleWeight: "", growthRequirement: "", nutrientType: "", minvalue: 0.0,maxvalue: 0.0)
    }
    
    init(cattleWeight:String,growthRequirement:String,nutrientType:String,minvalue:Float,maxvalue:Float){
        self.cattleWeight = cattleWeight
        self.growthRequirement = growthRequirement
        self.nutrientType = nutrientType
        self.minvalue = minvalue
        self.maxvalue = maxvalue
    }
}

struct TemporaryNutreints {
    static var shared = Nutreints()
    var cattleWeight:String
    var growthRequirement:String
    var nutrientType:String
    var minvalue:Float
    var maxvalue:Float
    init(){
        self.init(cattleWeight: "", growthRequirement: "", nutrientType: "", minvalue: 0.0,maxvalue: 0.0)
    }
    
    init(cattleWeight:String,growthRequirement:String,nutrientType:String,minvalue:Float,maxvalue:Float){
        self.cattleWeight = cattleWeight
        self.growthRequirement = growthRequirement
        self.nutrientType = nutrientType
        self.minvalue = minvalue
        self.maxvalue = maxvalue
    }
}

class TemporaryNutrientsRange{
    
    static var shared = TemporaryNutrientsRange()
    
    var temp_nutrients:[TemporaryNutreints] = []

    func deletePreviousData(){
        temp_nutrients = []
    }
    
    func addNutrients(nutrient:TemporaryNutreints){
        temp_nutrients.append(nutrient)
    }
}
//var feedstuffs = [Ingredient(name: "Corn", ca: 1.0, nem: 2.0, neg: 3.0, ee: 4.0, p: 5.0), Ingredient(name: "Soya", ca: 2.0, nem: 1.0, neg: 0.0, ee: 0.5, p: 1.0)]
