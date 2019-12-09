//
//  Ingredients.swift
//  ImplementingBackendless
//
//  Created by Student on 10/8/19.
//  Copyright © 2019 Peddinti,Suresh Chandra. All rights reserved.
//

import Foundation

@objcMembers
class Ingredients:NSObject {
    var _id:String
    var name:String
    var DM:Double
    var TDM:Double
    var NEm:Double
    var NEg:Double
    var NEi:Double
    var CP:Double
    var UIP:Double
    var CF:Double
    var ADF:Double
    var NDF:Double
    var eNDF:Double
    var EE:Double
    var Ash:Double
    var Ca:Double
    var P:Double
    var K:Double
    var CI:Double
    var S:Double
    var Znppm:Double
    var objectId:String?
    
    convenience override init(){
        self.init(_id:"",name:"",DM:0.0,
                  TDM:0.0,
                  NEm:0.0,
                  NEg:0.0,
                  NEi:0.0,
                  CP:0.0,
                  UIP:0.0,
                  CF:0.0,
                  ADF:0.0,
                  NDF:0.0,
                  eNDF:0.0,
                  EE:0.0,
                  Ash:0.0,
                  Ca:0.0,
                  P:0.0,
                  K:0.0,
                  CI:0.0,
                  S:0.0,
                  Znppm:0.0)
    }
    
    init(_id:String,name:String,DM:Double,
         TDM:Double,
         NEm:Double,
         NEg:Double,
         NEi:Double,
         CP:Double,
         UIP:Double,
         CF:Double,
         ADF:Double,
         NDF:Double,
         eNDF:Double,
         EE:Double,
         Ash:Double,
         Ca:Double,
         P:Double,
         K:Double,
         CI:Double,
         S:Double,
         Znppm:Double){
        self._id = _id
        self.name = name
        self.DM = DM
        self.TDM = TDM
        self.NEm = NEm
        self.NEg = NEg
        self.NEi = NEi
        self.CP = CP
        self.UIP = UIP
        self.CF = CF
        self.ADF = ADF
        self.NDF = NDF
        self.eNDF = eNDF
        self.EE = EE
        self.Ash = Ash
        self.Ca = Ca
        self.P = P
        self.K = K
        self.CI = CI
        self.S = S
        self.Znppm = Znppm
    }
    
}


class Ingreed
{
    let backendless = Backendless.sharedInstance()!
    var ingDataStore:IDataStore!
    
    var ing2:[Ingredients] = []
    
    var allIngredients:[Ingredients] = []
    //var allIngredientsList:[Ingredients] = []
    var firstIngredients:Ingredients!
    var lastIngredients:Ingredients!
    
    
    func saveIngredient(ingredient:Ingredients){
        ingDataStore.save(ingredient) as! Ingredients
    }
    
    func retrieveLastIngridient(){
        lastIngredients = ingDataStore.findLast() as? Ingredients
    }
    
    func retreiveAllIngredients(){
        allIngredients = []
        let queryBuilder = DataQueryBuilder()
        queryBuilder!.setPageSize(100)
        let totalList = ingDataStore.getObjectCount()!
        
        var i = 1
        for _ in stride(from: 0, through: (Int(totalList))/100, by: 1){
            queryBuilder?.setWhereClause("_id>=\(i) AND _id<\(i+100)")
            queryBuilder?.setSortBy(["name"])
            allIngredients += ingDataStore.find(queryBuilder) as! [Ingredients]
            i = i + 100
        }
        print("The total count:",allIngredients.count)
    }
    
    static var shared = Ingreed()
    //static var ing:[Ingredients] = []
    
    init() {
        ingDataStore = backendless.data.of(Ingredients.self)
    }
}

