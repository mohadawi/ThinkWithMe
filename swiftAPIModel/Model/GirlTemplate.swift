//
//  GirlTemplate.swift
//  swiftAPIModel
//
//  Created by Mohammad Dawi on 5/28/23.
//  Copyright © 2023 Mohammad Dawi. All rights reserved.
//

import Foundation
class GirlTemplate:Template{
    
    var tmplateID:String
    //var fields: NSMutableDictionary = [:]
    var fields:[Field] = []
    /*
    func addFieldTemplate(fTemplate:FieldProperty) {
        fieldsTemplates[fTemplate.getID()]=fTemplate
    }
     */
    func addField(f:Field?) {
        fields.append(f!)
    }
    init(tID:String) {
        tmplateID=tID
    }
    func getID() ->String {
        return tmplateID
    }
    func getFields() -> [Field] {
        return fields
    }
    
}
