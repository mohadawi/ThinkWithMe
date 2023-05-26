//
//  CompositeRule.swift
//  swiftAPIModel
//
//  Created by Mohammad Dawi on 3/19/23.
//  Copyright © 2023 Mohammad Dawi. All rights reserved.
//

import Foundation
class CompositeRule:IRule{
    func isSatisfiedBy(field: Field) -> Bool {
        return false
    }
    
    func And(other: IRule)->IRule{
        return AndRule(r1: self,r2: other)!
    }
}

class AndRule:CompositeRule{
   
    override func isSatisfiedBy(field f: Field) -> Bool {
        return rule1.isSatisfiedBy(field: f) || rule2.isSatisfiedBy(field: f)
    }
    var rule1: IRule
    var rule2: IRule
    init? (r1:IRule, r2:IRule){
        rule1 = r1
        rule2 = r2
    }
}
