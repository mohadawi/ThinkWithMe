//
//  PropertyWindowFactory.swift
//  swiftAPIModel
//
//  Created by Mohammad Dawi on 9/24/23.
//  Copyright © 2023 Mohammad Dawi. All rights reserved.
//

import Foundation

class PropertyWindowFactory{
    static func create(itemType: String, label: String,desiredList :[String]=[]) -> (FieldProperty) {
            //consider changing this to an accurate way
            let randomId = Int.random(in: 1..<5000)
            switch (itemType)
            {
                case "DesiredValue":
                    let tempId = "extra" + String(randomId)
                    return DesiredValueFieldProperty(pId: tempId,pLabel: label,desiredValues:desiredList);
                
            default:
                return DesiredValueFieldProperty();
        }
    }
}


