//
//  FilterItems.swift
//  swiftAPIModel
//
//  Created by Mohammad Dawi on 10/2/23.
//  Copyright © 2023 Mohammad Dawi. All rights reserved.
//

import Foundation
class FilterItems
{
    static func filterItemsBy(rule: IRule, items: [Item])->[Item]
    {
        //let itemType = String(describing: type(of: items))
        var neededItems = [Item]()
        for i in items
        {
            for f in i.fields{
                if (rule.isSatisfiedBy(field: f))
                {
                    neededItems.append(i)
                    break
                }
            }
        }
        return neededItems
    }
}
