//
//  Item.swift
//  swiftAPIModel
//
//  Created by Mohammad Dawi on 3/3/23.
//  Copyright © 2023 Mohammad Dawi. All rights reserved.
//

import Foundation
class Item{
    func getDisplayInfo(displayDict: inout NSMutableDictionary){}
}


/*
class FilterItems
{
    static func filterItemsBy(rule: IRule, items: [Item])->[Item]
    {
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
 */

