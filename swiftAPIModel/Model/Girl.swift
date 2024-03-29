//
//  Girl.swift
//  swiftAPIModel
//
//  Created by Mohammad Dawi on 3/26/23.
//  Copyright © 2023 Mohammad Dawi. All rights reserved.
//

import Foundation
class Girl:Item{
    var girlTempateID:String?
    var girlID:Int?
    var girlName: TextField?
    var eyesColor: TextField?
    var thumbnailUrl: String?
    var wiki: String?
    
    override init(){
        super.init()
    }
    
    init(templateID:String,templateFields:[Field]){
        super.init()
        girlTempateID = templateID
        fields = templateFields
    }
    
    func mapFields(){
        //try a smart way to search for the matching field!
        for f in fields{
            if f.getLabel().contains("Name"){
                girlName=TextField(fId:f.getID(), fLabel: f.getLabel(), val: "",properties:f.getPropertiesIDs())
            }
            if f.getLabel().contains("Color"){
                eyesColor=TextField(fId:f.getID(), fLabel: f.getLabel(), val: "",properties:f.getPropertiesIDs())
            }
        }
        //remove the template fields and add the actual fields
        //Note this should be made more dynamic like using a dictionary for all fields
        fields.removeAll()
        //add the actual fields
        fields.append(contentsOf:[girlName!,eyesColor!])
        
    }
    override func getDisplayInfo(displayDict: inout NSMutableDictionary) {
        displayDict["layla1"] = girlName ?? "i am in";
        displayDict["layla2"] = girlID ?? 1;
        displayDict["layla3"] = eyesColor ?? "fudge";
        displayDict["layla4"] = thumbnailUrl ?? "https://avatars1.githubusercontent.com/u/1961952?v=4";
        displayDict["layla5"] = wiki ?? "www.google.com";
    }
}
