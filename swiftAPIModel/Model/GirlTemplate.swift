//
//  GirlTemplate.swift
//  swiftAPIModel
//
//  Created by Mohammad Dawi on 5/28/23.
//  Copyright © 2023 Mohammad Dawi. All rights reserved.
//

import Foundation
class GirlTemplate:Template{
    var tmpID:String
    var fieldsTemplates: NSMutableDictionary = [:]
    //var fieldsTemplates:[FieldTemplate] = []
    func addFieldTemplate(fTemplate:FieldTemplate) {
        fieldsTemplates[fTemplate.getID()]=fTemplate
    }
    init(tID:String) {
        tmpID=tID
    }
    func getID() ->String {
        return tmpID
    }
}
