//
//  Girl.swift
//  swiftAPIModel
//
//  Created by Mohammad Dawi on 3/26/23.
//  Copyright © 2023 Mohammad Dawi. All rights reserved.
//

import Foundation
class Girl:Item{
    var girlID:Int?
    var girlName: TextField?
    var eyesColor: TextField?
    var thumbnailUrl: String?
    var wiki: String?
    init?(gID:Int, gName:TextField, eColor:TextField){
        girlID = gID
        girlName = gName
        eyesColor = eColor
    }
    
    override func getDisplayInfo(dict: inout NSMutableDictionary) {
        dict["layla1"] = girlName ?? "i am in";
        dict["layla2"] = girlID ?? 1;
        dict["layla3"] = eyesColor ?? "fudge";
        dict["layla4"] = thumbnailUrl ?? "https://avatars1.githubusercontent.com/u/1961952?v=4";
        dict["layla5"] = wiki ?? "www.google.com";
    }
}
