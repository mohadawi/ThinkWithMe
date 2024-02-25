//
//  ValueGreaterThanRule.swift
//  swiftAPIModel
//
//  Created by Mohammad Dawi on 3/26/23.
//  Copyright © 2023 Mohammad Dawi. All rights reserved.
//


import Foundation

class ValueGreaterThanRule:CompositeRule{
    //var value: String?
    var pTemplate: FieldProperty
    init?(fP:FieldProperty){
        pTemplate = fP
    }
    override func isSatisfiedBy(i: Item) ->Bool {
        for f in i.fields{
            for p in f.getPropertiesIDs(){
                if p == self.getID() {
                    if pTemplate.getThreshHold() < f.getNumberValue(){
                    return true
                }
            }
        }
    }
    return false
}
    override func isSatisfiedBy(f: Field) ->Bool {
        
        for p in f.getPropertiesIDs(){
            if p == self.getID() {
                if pTemplate.getThreshHold() < f.getNumberValue(){
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
