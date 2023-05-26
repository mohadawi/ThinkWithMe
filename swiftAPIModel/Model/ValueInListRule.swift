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
    var fTemplate: FieldTemplate
    init?(fT:FieldTemplate){
        fTemplate = fT
    }
    override func isSatisfiedBy(field: Field) -> Bool {
        for c in fTemplate.getValuesList(){
            if c == field.getStringValue(){
                return true
            }
        }
        return false
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

