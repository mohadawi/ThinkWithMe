//
//  ItemFactory.swift
//  swiftAPIModel
//
//  Created by Mohammad Dawi on 3/4/23.
//  Copyright © 2023 Mohammad Dawi. All rights reserved.
//

import Foundation

class ItemFactory{
    func getItems(itemType: String,classDictionary: Array<Any>?,classDictionary1: NSDictionary?) -> (Array<Item>,Int) {
        switch (itemType)
        {
            case "Pizza":
                return Pizza.create(fromDictionary: classDictionary);
            case "Repository":
                return Repository.create(fromDictionary: classDictionary1);
            case "Marvel":
            return Marvel.create(fromDictionary: classDictionary1);
            default:
                let items = [Item]()
                let totalCount = 0;
                return (items,totalCount);
                //throw exception;
        }
    }
}
