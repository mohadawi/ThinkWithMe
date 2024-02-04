//
//  IField.swift
//  swiftAPIModel
//
//  Created by Mohammad Dawi on 3/19/23.
//  Copyright © 2023 Mohammad Dawi. All rights reserved.
//

import Foundation
class TextField:Field{
    
    var fieldID: String
    var fieldLabel: String
    var value: String
    var propertiesIDs: [String]
    init?(fId:String,fLabel:String,val:String,properties:[String]=[]){
        fieldID = fId
        fieldLabel = fLabel
        value = val
        propertiesIDs=properties
    }
    func getStringValue() -> String{
        return value;
    }
    func getNumberValue() -> Double{
        return Double(value) ?? Double(FP_NAN)
    }
    func getID() -> String {
        return fieldID
    }
    func getLabel() -> String {
        return fieldLabel
    }
    func getPropertiesIDs() -> [String] {
        return propertiesIDs
    }
}

