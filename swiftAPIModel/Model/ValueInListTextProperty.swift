//
//  TextFieldProperty.swift
//  swiftAPIModel
//
//  Created by Mohammad Dawi on 9/24/23.
//  Copyright © 2023 Mohammad Dawi. All rights reserved.
//

import Foundation
class ValueInListTextProperty:FieldProperty{
    var propertyId: String
    var propertyLabel: String
    var preferredList: [String]?
    init(pId:String="", pLabel:String="", desiredValues:[String]=[]){
        propertyId = pId
        propertyLabel = pLabel
        preferredList = desiredValues
    }
    func getValuesList() -> [String]{
        return preferredList ?? []
    }
    func getID() -> String {
        return propertyId;
    }
    
    func getLabel() -> String {
        return propertyLabel
    }
    
    func getThreshHold() -> Double{
        return Double.infinity
    }
    
    func getTag() -> String {
        return ""
    }
    
}
