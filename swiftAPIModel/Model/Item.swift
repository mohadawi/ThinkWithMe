//
//  Item.swift
//  swiftAPIModel
//
//  Created by Mohammad Dawi on 3/3/23.
//  Copyright © 2023 Mohammad Dawi. All rights reserved.
//

import Foundation
class Item{
    var fields:[Field]
    func getDisplayInfo(displayDict: inout NSMutableDictionary){}
    init() {
        fields = []
    }
}

