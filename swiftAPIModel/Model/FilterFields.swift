//
//  FilterFields.swift
//  swiftAPIModel
//
//  Created by Mohammad Dawi on 9/24/23.
//  Copyright © 2023 Mohammad Dawi. All rights reserved.
//

import Foundation
class FilterFields
{
    static func filterFieldsBy(rule: IRule, fields: [Field])->[Field]
    {
        var neededFields = [Field]()
        for f in fields
        {
            if (rule.isSatisfiedBy(f: f))
            {
                neededFields.append(f)
            }
        }
        return neededFields
    }
}
