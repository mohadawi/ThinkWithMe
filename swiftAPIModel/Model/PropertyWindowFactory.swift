//
//  PropertyWindowFactory.swift
//  swiftAPIModel
//
//  Created by Mohammad Dawi on 9/24/23.
//  Copyright © 2023 Mohammad Dawi. All rights reserved.
//

import Foundation

class PropertyWindowFactory{
    static func create(itemType: String, label: String,desiredList :[String]=[],propertyWindowDictionary: Dictionary<String, Any>) -> (FieldProperty) {
            //consider changing this to an accurate way
            let randomId = Int.random(in: 1..<5000)
            switch (itemType)
            {
                case "ValueInList":
                    //create a temporary ID
                    let tempId = "valueInList_" + String(randomId)
                    return ValueInListTextProperty(pId: tempId,pLabel: label,desiredValues:desiredList);
                case "ValueGreaterThan":
                    let tempId = "valueGreaterThan_" + String(randomId)
                    let s=propertyWindowDictionary["Threshhold"] as! Int
                    let d = Double(s)
                    return ValueGreaterThanNumberProperty(pId: tempId,pLabel: label,desiredThreshHold:d)
                case "ContainsText":
                    let tempId = "containsText_" + String(randomId)
                    let tag=propertyWindowDictionary["Tag"] as! String
                    return ContainsTextProperty(pId: tempId, pLabel: label, textTag: tag)
                default:
                    return ValueInListTextProperty();
        }
    }
}


