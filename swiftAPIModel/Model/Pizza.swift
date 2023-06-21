//
//  Pizza.swift
//
//  Created by Mohammad Dawi on 12/30/21.


//https://jsoneditoronline.org/#left=local.tiluqu&right=local.foxora
import Foundation

//Our data Model for the pizza menu
//This class is semi-generic, used by me before to model git repository
class Pizza:Item {
    
    //MARK: Properties
    
    var itemId: String
    var name: String
    var price: String //ownerName
    
    var category: String? //description
    var description: String?
    var thumbnailUrl: String?
    var topping: [String]?
    var rank: String?//starCount
    var wiki: String?
    
    
    //MARK: Initialization
    
    init?(itemId: String, name: String, category: String?, price: String, topping: [String]?, rank: String?) {
        
        // The item ID must not be empty
        guard !itemId.isEmpty else {
            return nil
        }
        // The item name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        // The item price must not be empty
        guard !price.isEmpty else {
            return nil
        }
        
        // Initialize stored properties.
        self.itemId = itemId
        self.name = name
        self.category = category
        self.price = price
        self.thumbnailUrl = "https://g.foolcdn.com/image/?url=https%3A//g.foolcdn.com/editorial/images/593245/pizza.jpg&w=2000&op=resize"
        self.rank = rank
        self.wiki = "https://www.istockphoto.com/photo/pizza-margherita-gm471630644-63408063"
    }
    
    static func create(fromDictionary classDictionary: Array<Any>?) -> (Array<Item>,Int) {
        //get the total count
        var totalCount:Int?
        var items = [Pizza]()
        totalCount = classDictionary?.count
        if let elements = classDictionary! as? Array<Any>{//classDictionary should be a dictionary but not in this api!
            for (obj) in elements {
                //loop on the results per page
                let c = obj as Any
                if let ele = c as? [String:Any]{
                    //get the repo id, name, owner's name
                    let tId = "\(ele["id"] ?? ""))"
                    
                    //fill name if any
                    var name = ""
                    if let name1 = ele["name"] as? String
                    {
                        name = name1
                    }
                    else{
                        // name must not be nil
                        name="vegeterian"
                    }
                    
                    //fill price if any
                    var price = ""
                    if let price1 = ele["price"] as? NSNumber
                    {
                        price = price1.stringValue
                    }
                    else{
                        // name must not be nil
                        price="100000LL"
                    }

                    //create a new repository "article" with fetched id, name and date
                    guard let item = Pizza(itemId: tId, name: name, category: nil, price: price, topping: nil, rank: nil) else {
                        print("Unable to get item")
                        continue
                    }
                    
                    //fill topping if any
                    if let topping = ele["topping"] as? [String]
                    {
                        item.topping = topping
                    }
                    
                    //read the stars count as NSNumber if any then cast it to string
                    if let rank = ele["rank"] as? NSNumber{
                        item.rank = rank.stringValue
                    }
                    
                    
                    //get the item category if any
                    if let category = ele["category"] as? String {
                        item.category = category
                    }
                    
                    //get the item category if any
                    if let description = ele["description"] as? String {
                        item.description = description
                    }
                    
                    //add the created item to the items array
                    items.append(item)
                }
            }
        }
        return (items,totalCount!)
    }
    override func getDisplayInfo(displayDict dict: inout NSMutableDictionary) {
        dict["layla1"] = name ?? "i am in";
        dict["layla2"] = price ?? 1;
        dict["layla3"] = description ?? "fudge";
        dict["layla4"] = thumbnailUrl ?? "https://avatars1.githubusercontent.com/u/1961952?v=4";
        dict["layla5"] = wiki ?? "www.google.com";
        
    }
}
