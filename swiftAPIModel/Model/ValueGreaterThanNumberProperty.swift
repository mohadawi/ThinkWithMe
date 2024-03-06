//
//  ValueGreaterThanNumberProperty.swift
//  swiftAPIModel
//
//  Created by Mohammad Dawi on 1/31/24.
//  Copyright © 2024 Mohammad Dawi. All rights reserved.
//

import Foundation
class ValueGreaterThanNumberProperty:FieldProperty{
    func getValuesList() -> [String] {
        return []
    }
    var propertyId: String
    var propertyLabel: String
    var threshHold: Double
    init(pId:String="", pLabel:String="", desiredThreshHold:Double=0.0){
        propertyId = pId
        propertyLabel = pLabel
        threshHold = desiredThreshHold
    }
    func getThreshHold() -> Double{
        return threshHold
    }
    func getID() -> String {
        return propertyId;
    }
    
    func getLabel() -> String {
        return propertyLabel
    }
    func getTag() -> String {
        return ""
    }
    
}
