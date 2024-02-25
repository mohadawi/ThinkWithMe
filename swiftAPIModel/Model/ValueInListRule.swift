//
//  EyesColor.swift
//  swiftAPIModel
//
//  Created by Mohammad Dawi on 3/19/23.
//  Copyright © 2023 Mohammad Dawi. All rights reserved.
//

import Foundation
/*
protocol EyesColor:IRule {
    
}*/
class ValueInListRule:CompositeRule{
    //var value: String?
    var pTemplate: FieldProperty
    init?(fP:FieldProperty){
        pTemplate = fP
    }
    override func isSatisfiedBy(i: Item) -> Bool {
        //if type(of:field.getTemplate()) == type(of: pTemplate) {
        for field in i.fields{
            for p in field.getPropertiesIDs(){
                if p == self.getID() {
                    for c in pTemplate.getValuesList()
                    {
                        if c == field.getStringValue()
                        {
                            return true
                        }
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
                for c in pTemplate.getValuesList()
                {
                    if c == f.getStringValue()
                    {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    override func getID() -> String {
        return pTemplate.getID()
    }
}



/*
class brownEyes:CompositeRule{
    override func isSatisfiedBy(field: Field) -> Bool {
        for c in field.eyesColor{
            if c == "Brown"{
                return true
            }
        }
        return false
    }
}

class greenEyes:CompositeRule{
    override func isSatisfiedBy(field: Field) -> Bool {
        for c in field.eyesColor{
            if c == "Green"{
                return true
            }
        }
        return false
    }
}
 */

