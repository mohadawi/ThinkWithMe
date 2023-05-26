//
//  IField.swift
//  swiftAPIModel
//
//  Created by Mohammad Dawi on 3/19/23.
//  Copyright © 2023 Mohammad Dawi. All rights reserved.
//

import Foundation
class TextField:Field{
    var fieldId: String
    var fieldLabel: String
    var value: String
    init?(fId:String, fLabel:String, val:String){
        fieldId = fId
        fieldLabel = fLabel
        value = val
    }
    func getStringValue() -> String{
        return value;
    }
    func getNumberValue() -> Double{
        return Double(FP_NAN)
    }
}

class TextFieldTemplate:FieldTemplate{
    var fieldId: String
    var fieldLabel: String
    var valuesList: [String]
    var value: String?
    init?(fId:String, fLabel:String, desiredValues:[String]){
        fieldId = fId
        fieldLabel = fLabel
        valuesList = desiredValues
    }
    func getValuesList() -> [String]{
        return valuesList
    }
}

class FilterFields
{
    static func filterFieldsBy(rule: IRule, fields: [Field])->[Field]
    {
        var neededFields = [Field]()
        for f in fields
        {
            if (rule.isSatisfiedBy(field: f))
            {
                neededFields.append(f)
            }
        }
        return neededFields
    }
}
