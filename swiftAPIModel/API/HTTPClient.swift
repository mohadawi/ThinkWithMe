//
//  HTTPClient.swift
//
//  Mohammad Dawi
// note this class is semi-generic, just need to maipulate the type of the json response

import Foundation
import UIKit

class HTTPClient {
    //holds the rpeos list (is it useful to consider moving it up level in listAPI class?!)
    var repos = /*[Repository]()*/[Item]()
    var totalCount:Int = 0

    init() {
        
    }
    //get the list of repos "articles" (request returns 10 results per page)
    func getRequestAPICall(_ apiUurl: String?,_ type :String?,completion: @escaping (Error?) -> Void)
     {
        let itemFactory = ItemFactory()
        repos.removeAll()
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let request = NSMutableURLRequest()
        request.httpMethod = "GET"
        request.url = URL(string: apiUurl!)
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            if error != nil {
                completion (error)
                return
            }
            var object: Any? = nil
            if let data = data {
                object = try? JSONSerialization.jsonObject(with: data, options: [])
            }
            if let object1 = object as? Array<Any>{
                //if let characters1 = object1["response"] as? [String:Any]{
                let (arr,count)=itemFactory.getItems(itemType: type!, classDictionary: object1, classDictionary1:nil)
                self.repos.append(contentsOf:arr)
                    self.totalCount=count
            }
            else if let object1 = object as? NSDictionary{
                //if let characters1 = object1["response"] as? [String:Any]{
                    let (arr,count)=itemFactory.getItems(itemType: type!, classDictionary:nil , classDictionary1:object1)
                self.repos.append(contentsOf:arr)
                self.totalCount=count
                
                
                //create a name filter
                var nameProperty = PropertyWindowFactory.create(itemType: "ValueInList", label: "name filter",desiredList: [ "Abyss","Aginar"], propertyWindowDictionary: Dictionary<String, Any>())
                guard let nameRule = ValueInListRule(fP: nameProperty)
                    else {
                        return
                }
                guard let nameRule2 = IsRule(fP: nameProperty,val:"Aginar")
                    else {
                        return
                }
                //create a stars filter
                var propertyDict = Dictionary<String, Any>()
                propertyDict["Threshhold"] = 6
                var starsProperty = PropertyWindowFactory.create(itemType: "ValueGreaterThan", label: "stars filter", propertyWindowDictionary: propertyDict)
                guard let starsRatingRule = ValueGreaterThanRule(fP: starsProperty)
                    else {
                        return
                }
                //add a composite rule
                let c1 = nameRule.Or(other: starsRatingRule).And(other: nameRule2) as! CompositeRule
                
                //add the filter ID to the name of the repository
                for repo in self.repos{
                    repo.getName().propertiesIDs.append(nameProperty.getID())
                    repo.fields.append(repo.getName())
                    repo.getStarsCount().propertiesIDs.append(starsProperty.getID())
                    repo.fields.append(repo.getStarsCount())
                    
                }
                //apply the filter to a temp list
                var marvelFilter = FilterItems.filterItemsBy(rule: c1, items: self.repos)
                //replace the original list with the filtered list
                
                //apply the filter to the repos
                self.repos = marvelFilter
                
            }
            //}
            completion (error)
        })
        task.resume()
    }
    
    func getRepos(url:String?,itemType:String?,completion: @escaping (Error?) -> Void) {
        getRequestAPICall(url,itemType,completion:{(error) in
            completion(error)
            if(error == nil){
                // do something if needed
            }
        })
    }
    
    func downloadImage(_ url: String) -> UIImage? {
        let aUrl = URL(string: url)
        guard let data = try? Data(contentsOf: aUrl!),
            let image = UIImage(data: data) else {
                return nil
        }
        return image
    }
    
}
