//
//  TextFieldProperty.swift
//  swiftAPIModel
//
//  Created by Mohammad Dawi on 9/24/23.
//  Copyright © 2023 Mohammad Dawi. All rights reserved.
//

import Foundation
class TextFieldProperty:FieldProperty{
    
    var propertyId: String
    var propertyLabel: String
    var keywordsList: [String]?
    var value: String?
    init(pId:String="", pLabel:String="", desiredValues:[String]=[]){
        propertyId = pId
        propertyLabel = pLabel
        keywordsList = desiredValues
    }
    func getValuesList() -> [String]{
        return keywordsList ?? []
    }
    func getID() -> String {
        return propertyId;
    }
    
    func getLabel() -> String {
        return propertyLabel
    }
    
}
