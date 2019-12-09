//
//  NutrientValues.swift
//  RationBalancing
//
//  Created by Student on 10/12/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import Foundation

@objcMembers
class NutrientValues:NSObject {
    var cattleWeight:String
    var growthRequirement:String
    var id:Int
    var maxvalue:Double
    var minvalue:Double
    var nutrientType:String
      var objectId:String?
    
    convenience override init(){
        self.init(cattleWeight:"",
                  growthRequirement:"",
                  id:0,
                  maxvalue:0.0,
                  minvalue:0.0,
                  nutrientType:"")
    }
    
    init(cattleWeight:String,growthRequirement:String,id:Int,maxvalue:Double,minvalue:Double,nutrientType:String){
        self.cattleWeight = cattleWeight
        self.growthRequirement = growthRequirement
        self.id = id
        self.maxvalue = maxvalue
        self.minvalue = minvalue
        self.nutrientType = nutrientType
    }
    
}

class NutrientList
{
    let backendless = Backendless.sharedInstance()!
    var nutDataStore:IDataStore!
    
    var allNutrients:[NutrientValues] = []
    var firstNutrient:NutrientValues!
    var lastNutrient:NutrientValues!
    
    static var shared = NutrientList()
    
    init() {
        nutDataStore = backendless.data.of(NutrientValues.self)
    }

    func retreiveAllNutrients(){
        allNutrients = []
        let queryBuilder = DataQueryBuilder()
        queryBuilder!.setPageSize(100)
        let totalList = nutDataStore.getObjectCount()!
        print(totalList)
        var i = 1
        for _ in stride(from: 0, through: (Int(totalList))/100, by: 1){
            queryBuilder?.setWhereClause("id>=\(i) AND id<\(i+100)")
            queryBuilder?.setSortBy(["nutrientType"])
            allNutrients += nutDataStore.find(queryBuilder) as! [NutrientValues]
            i = i + 100
        }
        print("The total count:",allNutrients.count)
    }
    
}




@objcMembers
class TemporaryNutrientValues:NSObject {
    var cattleWeight:String
    var growthRequirement:String
    var maxvalue:Double
    var minvalue:Double
    var nutrientType:String
    var objectId:String?
    
    convenience override init(){
        self.init(cattleWeight:"",
                  growthRequirement:"",
                  maxvalue:0.0,
                  minvalue:0.0,
                  nutrientType:"")
    }
    
    init(cattleWeight:String,growthRequirement:String,maxvalue:Double,minvalue:Double,nutrientType:String){
        self.cattleWeight = cattleWeight
        self.growthRequirement = growthRequirement
        self.maxvalue = maxvalue
        self.minvalue = minvalue
        self.nutrientType = nutrientType
    }
    
}

class TemporaryNutrientList
{
    let backendless = Backendless.sharedInstance()!
    var nutDataStore:IDataStore!
     var allTempNutrients:[TemporaryNutrientValues] = []
    
    static var shared = TemporaryNutrientList()
    //static var ing:[Ingredients] = []
    
    init() {
        nutDataStore = backendless.data.of(TemporaryNutrientValues.self)
    }
    
    func saveTemporaryIngredient(tempNutrientValue:TemporaryNutrientValues){
        nutDataStore.save(tempNutrientValue) as! TemporaryNutrientValues
    }
    
    func countOfTempNutrients() -> Int{
        print(Int(nutDataStore.getObjectCount()))
        return Int(nutDataStore.getObjectCount())
    }
    
    func retreiveAllTempNutrients(){
        let queryBuilder = DataQueryBuilder()
        queryBuilder?.setSortBy(["nutrientType"])
        allTempNutrients = nutDataStore.find(queryBuilder) as! [TemporaryNutrientValues]
    }
    
    func removeNutrients(){
        retreiveAllTempNutrients()
        for i in allTempNutrients{
             nutDataStore.remove(i)
        }
       
    }
}
