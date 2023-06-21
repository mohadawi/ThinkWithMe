//
//  Girl.swift
//  swiftAPIModel
//
//  Created by Mohammad Dawi on 3/26/23.
//  Copyright © 2023 Mohammad Dawi. All rights reserved.
//

import Foundation
class Girl:Item{
    var girlTempateID:String
    var girlID:Int?
    var girlName: TextField?
    var eyesColor: TextField?
    var thumbnailUrl: String?
    var wiki: String?
    
    init(templID:String){
        girlTempateID = templID
    }
    
    func addField(field:Field){
        fields.append(field)
        //try a smart way to search for the matching field!
        if field.getLabelValue().contains("Name"){
            girlName=field as? TextField
        }
        if field.getLabelValue().contains("color"){
            eyesColor=field as? TextField
        }

    }
    override func getDisplayInfo(displayDict: inout NSMutableDictionary) {
        displayDict["layla1"] = girlName ?? "i am in";
        displayDict["layla2"] = girlID ?? 1;
        displayDict["layla3"] = eyesColor ?? "fudge";
        displayDict["layla4"] = thumbnailUrl ?? "https://avatars1.githubusercontent.com/u/1961952?v=4";
        displayDict["layla5"] = wiki ?? "www.google.com";
    }
}
