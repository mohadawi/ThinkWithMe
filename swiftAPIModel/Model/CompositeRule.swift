//
//  CompositeRule.swift
//  swiftAPIModel
//
//  Created by Mohammad Dawi on 3/19/23.
//  Copyright © 2023 Mohammad Dawi. All rights reserved.
//

import Foundation
class CompositeRule:IRule{
    func getID() -> String {
        return ""
    }
    
    func isSatisfiedBy(i: Item) -> Bool {
        return false
    }
    
    func isSatisfiedBy(f: Field) -> Bool {
        return false
    }
    
    func And(other: IRule)->IRule{
        return AndRule(r1: self,r2: other)!
    }
    
    func Or(other: IRule)->IRule{
        return OrRule(r1: self,r2: other)!
    }
}

class AndRule:CompositeRule{
   
    override func isSatisfiedBy(i: Item) -> Bool {
        return rule1.isSatisfiedBy(i: i) && rule2.isSatisfiedBy(i: i)
    }
    
    override func isSatisfiedBy(f: Field) -> Bool {
        return rule1.isSatisfiedBy(f: f) && rule2.isSatisfiedBy(f: f)
    }
    
    var rule1: IRule
    var rule2: IRule
    init? (r1:IRule, r2:IRule){
        rule1 = r1
        rule2 = r2
    }
}

class OrRule:CompositeRule{
   
    override func isSatisfiedBy(i: Item) -> Bool {
        return rule1.isSatisfiedBy(i: i) || rule2.isSatisfiedBy(i: i)
    }
    
    override func isSatisfiedBy(f: Field) -> Bool {
        return rule1.isSatisfiedBy(f: f) || rule2.isSatisfiedBy(f: f)
    }
    
    var rule1: IRule
    var rule2: IRule
    init? (r1:IRule, r2:IRule){
        rule1 = r1
        rule2 = r2
    }
}
