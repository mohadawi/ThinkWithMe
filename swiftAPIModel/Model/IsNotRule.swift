//
//  IsNotRule.swift
//  swiftAPIModel
//
//  Created by Mohammad Dawi on 3/3/24.
//  Copyright © 2024 Mohammad Dawi. All rights reserved.
//

import Foundation
class IsNotRule:CompositeRule{
    var value: String?
    var pTemplate: FieldProperty
    init?(fP:FieldProperty,val:String){
        pTemplate = fP
        value = val
    }
    override func isSatisfiedBy(i: Item) -> Bool {
        //if type(of:field.getTemplate()) == type(of: pTemplate) {
        for field in i.fields{
            for p in field.getPropertiesIDs(){
                if p == self.getID() {
                    if field.getStringValue() == value
                    {
                        return false
                    }
                }
            }
        }
        return true
    }
    
    override func isSatisfiedBy(f: Field) -> Bool {
        //if type(of:field.getTemplate()) == type(of: pTemplate) {
        for p in f.getPropertiesIDs(){
            if p == self.getID() {
                if value == f.getStringValue()
                {
                    return false
                }
            }
        }
        return true
    }
    
    override func getID() -> String {
        return pTemplate.getID()
    }
}
