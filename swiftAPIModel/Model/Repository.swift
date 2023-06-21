//
//  Repository.swift
//  swiftAPIModel
//
//  Created by Mohammad Dawi on 9/11/22.
//  Copyright © 2022 Mohammad Dawi. All rights reserved.
//

import Foundation
import UIKit

//Our data Model for the guardian articles
//This class is semi-generic, used by me before to model git repository
class Repository:Item {
    
    //MARK: Properties
    
    var repoId: String
    var name: String
    var ownerName: String
    
    var description: String?
    var thumbnailUrl: String?
    var starCount: String?
    var wiki: String?
    
    
    //MARK: Initialization
    
    init?(repoId: String, name: String, description: String?, ownerName: String, thumbnailUrl: String?, starCount: String?, wiki: String?) {
        
        // The repo ID must not be empty
        guard !repoId.isEmpty else {
            return nil
        }
        // The repo name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        // The repo login must not be empty
        guard !ownerName.isEmpty else {
            return nil
        }
        
        // Initialize stored properties.
        self.repoId = repoId
        self.name = name
        self.description = description
        self.ownerName = ownerName
        self.thumbnailUrl = thumbnailUrl
        self.starCount = starCount
        self.wiki = wiki
        
    }
    
    static func create(fromDictionary classDictionary: NSDictionary?) -> (Array<Item>,Int) {
        //get the total count
        var totalCount:Int?
        var items = [Repository]()
        totalCount = classDictionary?.count
        if let characters1 = classDictionary!["response"] as? NSDictionary{
            if let total = characters1.value(forKey: "total") as? NSNumber{
                totalCount = total.intValue
            }
            if let characters = characters1["results"] as? NSArray{
                for (obj) in characters {
                    //loop on the results per page
                    if let character = obj as? NSDictionary {
                        //get the repo id, name, owner's name
                        let tId = "\(character.value(forKey: "id") ?? "")"
                        
                        //get the publication's date
                        var login = character.value(forKey: "webPublicationDate") as? String
                        // read the article date from string value
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
                        //dateFormatter.dateFormat = "yyyy-MM-dd"
                        let date = dateFormatter.date(from: login ?? "")
                        
                        // change to a readable time format and change to local time zone
                        dateFormatter.dateFormat = "EEE, MMM d, yyyy"
                        dateFormatter.timeZone = NSTimeZone.local
                        let timeStamp = dateFormatter.string(from: date ?? Date())
                        login = timeStamp
                        
                        //fill name if any
                        var name = ""
                        if let name1 = character.value(forKey: "sectionName") as? String
                        {
                            name = name1
                        }
                        else{
                            // name must not be nil
                            name="moha"
                        }
                        
                        //create a new repository "article" with fetched id, name and date
                        guard let repo = Repository(repoId: tId, name: name, description: nil, ownerName: login!, thumbnailUrl: nil, starCount: nil, wiki: nil) else {
                            print("Unable to instantiate repository")
                            continue
                        }
                        
                        //fill description if any
                        if let description = character.value(forKey: "webTitle") as? String
                        {
                            repo.description = description
                        }
                        
                        //read the stars count as NSNumber if any then cast it to string
                        if let stars = character.value(forKey: "starRating") as? NSNumber{
                            repo.starCount = stars.stringValue
                        }
                        
                        //get the thumbnail url if any
                        if let thumb = character["fields"]as? NSDictionary {
                            repo.thumbnailUrl = thumb.value(forKey: "thumbnail") as? String
                        }
                        
                        //get the web url if any
                        if let weburl = character["webUrl"] as? String {
                            repo.wiki = weburl
                        }
                        
                        //add the created repository to the repositories array
                        items.append(repo)
                    }
                }
            }
        }
        return (items,totalCount!)
    }
    
    override func getDisplayInfo(displayDict dict: inout NSMutableDictionary) {
        dict["layla1"] = name ?? "i am in";
        dict["layla2"] = starCount ?? "1";
        dict["layla3"] = description ?? "fudge";
        dict["layla4"] = thumbnailUrl ?? "https://avatars1.githubusercontent.com/u/1961952?v=4";
        dict["layla5"] = wiki ?? "www.google.com";
    }
}
