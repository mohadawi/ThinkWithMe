//
//  IRule.swift
//  swiftAPIModel
//
//  Created by Mohammad Dawi on 3/19/23.
//  Copyright © 2023 Mohammad Dawi. All rights reserved.
//

import Foundation
protocol IRule {
    func isSatisfiedBy(field: Field) -> Bool
    func And(other: IRule) -> IRule
}
