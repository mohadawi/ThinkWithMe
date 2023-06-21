//
//  IField.swift
//  swiftAPIModel
//
//  Created by Mohammad Dawi on 3/19/23.
//  Copyright © 2023 Mohammad Dawi. All rights reserved.
//

import Foundation
class TextField:Field{
    
    var templateID: String
    var fieldLabel: String
    var value: String
    init?(fieldTmpId:String,fieldTmpLabel:String,val:String){
        templateID = fieldTmpId
        fieldLabel = fieldTmpLabel
        value = val
    }
    func getStringValue() -> String{
        return value;
    }
    func getNumberValue() -> Double{
        return Double(FP_NAN)
    }
    func getTempID() -> String {
        return templateID
    }
    func getLabelValue() -> String {
        return fieldLabel
    }
    func getTemplateID() -> String {
        return templateID
    }
}

class TextFieldTemplate:FieldTemplate{
    var fieldTmpId: String
    var fieldTmpLabel: String
    var keywordsList: [String]?
    var value: String?
    init?(fId:String, fLabel:String, desiredValues:[String]=[]){
        fieldTmpId = fId
        fieldTmpLabel = fLabel
        keywordsList = desiredValues
    }
    func getValuesList() -> [String]{
        return keywordsList ?? []
    }
    func getID() -> String {
        return fieldTmpId;
    }
    func getLabel() -> String {
        return fieldTmpLabel
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
