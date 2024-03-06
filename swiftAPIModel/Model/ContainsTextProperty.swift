//
//  ContainsTextProperty.swift
//  swiftAPIModel
//
//  Created by Mohammad Dawi on 3/6/24.
//  Copyright © 2024 Mohammad Dawi. All rights reserved.
//

//
//  TextFieldProperty.swift
//  swiftAPIModel
//
//  Created by Mohammad Dawi on 9/24/23.
//  Copyright © 2023 Mohammad Dawi. All rights reserved.
//

import Foundation
class ContainsTextProperty:FieldProperty{
    
    var propertyId: String
    var propertyLabel: String
    var keyword: String
    init(pId:String="", pLabel:String="",textTag:String=""){
        propertyId = pId
        propertyLabel = pLabel
        keyword = textTag
    }
    func getValuesList() -> [String]{
        return []
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
        return keyword
    }
    
}

