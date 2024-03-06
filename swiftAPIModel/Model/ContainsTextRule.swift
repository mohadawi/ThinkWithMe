//
//  ContainsTextRule.swift
//  swiftAPIModel
//
//  Created by Mohammad Dawi on 3/6/24.
//  Copyright © 2024 Mohammad Dawi. All rights reserved.
//

import Foundation
class ContainsTextRule:CompositeRule{
    var pTemplate: FieldProperty
    init?(fP:FieldProperty){
        pTemplate = fP
    }
    override func isSatisfiedBy(i: Item) -> Bool {
        //if type(of:field.getTemplate()) == type(of: pTemplate) {
        for field in i.fields{
            for p in field.getPropertiesIDs(){
                if p == self.getID() {
                    if field.getStringValue().uppercased().contains(pTemplate.getTag().uppercased()) == true
                    {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    override func isSatisfiedBy(f: Field) -> Bool {
        //if type(of:field.getTemplate()) == type(of: pTemplate) {
        for p in f.getPropertiesIDs(){
            if p == self.getID() {
                if f.getStringValue().uppercased().contains(pTemplate.getTag().uppercased()) == true
                {
                    return true
                }
            }
        }
        return false
    }
    
    override func getID() -> String {
        return pTemplate.getID()
    }
}

