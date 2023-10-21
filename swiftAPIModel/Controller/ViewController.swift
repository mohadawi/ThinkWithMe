//
//  ViewController.swift
//  Mohammad Dawi

import UIKit
import WebKit

class ViewController: UIViewController,UISearchResultsUpdating,UISearchBarDelegate {
    
    private var delegate: AppDelegate?
    @IBOutlet var tableView: UITableView!
    
    
    let itemType = "Marvel"
    var imageURLs = [URL]()// holds the thumbnails urls of the guardian articles
    var searchImageURLs = [URL]()
    var downloadImageOperationQueue: OperationQueue? = OperationQueue()
    var operations = NSMutableDictionary()
    var images = NSMutableDictionary()
    
    var repos = /*[Repository]*/[Item]()// holds the guardian articles we want to list
    var searchdata = [Item]()
    var selectedRepo : /*Repository?*/ Item?// holds the article that was clicked or selected
    var totalReposCount:Int = 0 // total count of articles returned
    var currentReposCount:Int = 0
    var baseUrl:String =
    "https://gateway.marvel.com:443/v1/public/characters?apikey=21f76c4652c1d7a3063dbba2915e3e9a"
   
   
/* "https://content.guardianapis.com/search?api-key=302fe17b-9a43-4cf7-aa7c-2bf80a89dc8c&show-fields=starRating,thumbnail"// changes automatically
    *//* "https://private-anon-ba5c38fcb4-pizzaapp.apiary-mock.com/restaurants/restaurantId/menu?category=Pizza&orderBy=rank"*/
 
    var currentPage:Int = 1 // implement paging
    var pageCount:Int = 30 // changes automatically
    
    //search bar
    private var resultSearchController = UISearchController()
    
    // MARK: Search Bar delegate functions
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text=""
        self.tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(ViewController.reload), object: nil)
        self.reload(searchText: searchText)
        self.tableView.reloadData()
    }
    
    // reload the data when search text cahnges
    @objc func reload(searchText:String) {
        searchImageURLs.removeAll()
        var layla = NSMutableDictionary()
        searchdata = searchText.isEmpty ? repos : repos.filter
            {
                (item: Item) -> Bool in
                item.getDisplayInfo(displayDict: &layla)
                var name = layla["layla1"] as! String
                    return
                        name.range(of: searchText, options: .caseInsensitive, range: nil,
                locale: nil) != nil
        }
        var layla1 = NSMutableDictionary()
        for ele in searchdata {
            ele.getDisplayInfo(displayDict: &layla1)
            let imageURL = URL(string: layla1["layla4"] as! String ?? "https://avatars1.githubusercontent.com/u/1961952?v=4" )
            if let imageURL = imageURL {
                searchImageURLs.append(imageURL)
            }
        }
    }
    
    // MARK: Pass wiki "web url for article" to web view in detail view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //resultSearchController.isActive = false
        if let svc = segue.destination as? DetailViewCCViewController {
            var layla = NSMutableDictionary()
            selectedRepo?.getDisplayInfo(displayDict: &layla)
            svc.wiki = layla["layla4"] as! String//"https://www.istockphoto.com/"
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /**********************TESTING AREA************************************/
        //testing the Rules logic
        //create a gril template with 2 Text Fields ('Name' and 'eyes color')
        
        //create the fields templates first
        var eyesColorProperty = PropertyWindowFactory.create(itemType: "TextField", label: "eyes color",desiredList: ["Blue","Brown"])
        
        guard let name = TextField(fId:"Txt123", fLabel: "Name", val: "")
            else {
                return
        }
        guard let eyesColor = TextField(fId: "Txt124", fLabel: "Eyes Color", val: "",properties: [eyesColorProperty.getID()])
            else {
                return
        }
            
        //create a girl template and add the above fields
        var girlTemplate=GirlTemplate(tID: "GTmpl1")
        girlTemplate.addField(f: name)
        girlTemplate.addField(f: eyesColor)
        
        //create a Rasha instance
        let rasha = Girl(templateID: girlTemplate.getID(),templateFields: girlTemplate.fields)
        rasha.mapFields()
        rasha.girlName?.value = "Rasha"
        rasha.eyesColor?.value = "Blue"
        
        
        //create Sally instance
        let sally = Girl(templateID: girlTemplate.getID(),templateFields: girlTemplate.fields)
        sally.mapFields()
        sally.girlName?.value = "Sally"
        sally.eyesColor?.value = "Brown"
        
        
        //create Soha instance
        let soha = Girl(templateID: girlTemplate.getID(),templateFields: girlTemplate.fields)
        soha.mapFields()
        soha.girlName?.value = "Soha"
        soha.eyesColor?.value = "Black"
        
        
        
        var myCrushesEyes = [rasha.eyesColor,sally.eyesColor,soha.eyesColor]
        var eyes = [Field]()
        eyes.append(rasha.eyesColor!)
        eyes.append(sally.eyesColor!)
        eyes.append(soha.eyesColor!)
        
        var myCrushes = [rasha,sally,soha]
        
        
        // create a composited rule ( The hard thing is that how do we create this rule in the template!!
        var c1 = CompositeRule()
        guard let eColor = ValueInListRule(fT: eyesColorProperty)
            else {
                return
        }
        
        //c1 = blueEyes.And(other: greenEyes).And(other: brownEyes) as! CompositeRule
        //let c = c1.isSatisfiedBy(field: f1)
        
        
        //Get the fields to filter the crushes on
        
        //create a filter for the fields
        
        var eyesFilter = FilterFields.filterFieldsBy(rule: eColor, fields: myCrushesEyes as! [Field])
        
        var girlsFilter = FilterItems.filterItemsBy(rule: eColor, items: myCrushes)
        
        
        
        
        
    
        /**********************END TESTING AREA********************************/
        
        
        //add search controller as table view header
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.searchBar.delegate = self;
            tableView.tableHeaderView = controller.searchBar
            return controller
        })()
        //keep old search results when going back from detail view
        self.definesPresentationContext = true
        delegate = UIApplication.shared.delegate as? AppDelegate
        //set the initial url for api call
        
        
        baseUrl =
        
             "https://gateway.marvel.com:443/v1/public/characters?ts=1&apikey=21f76c4652c1d7a3063dbba2915e3e9a&hash=b9f2459786b5d727984973cc47a8f854"
             
        /*
             "https://content.guardianapis.com/search?api-key=302fe17b-9a43-4cf7-aa7c-2bf80a89dc8c&show-fields=starRating,thumbnail"
             */
        
        
        /* "https://private-anon-ba5c38fcb4-pizzaapp.apiary-mock.com/restaurants/restaurantId/menu?category=Pizza&orderBy=rank"
 */
        
        getReposPerPage(pageNum: currentPage)
    }
    
    //MARK: get the list of repositories per page
    func getReposPerPage(pageNum : Int){
        var url:String
        if (pageNum<2){
             url = baseUrl
        }
        else{
            url = baseUrl + "&page=" + "\(pageNum)"
        }
        
        // use singelton API class to access data "facade design pattern"
        LibraryAPI.shared.getRepos(url:url, itemType: itemType,completion:{(myRepos)     in
            if(myRepos != nil){
                self.totalReposCount = LibraryAPI.shared.getReposTotalCount()
                self.repos.append(contentsOf:myRepos)
                self.currentReposCount = self.repos.count
                self.pageCount=myRepos.count
                self.populateModels2(myRepos.count)
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
            }
        })
    }
    
    
    // MARK: Fill the avatars urls
    func populateModels2(_ count: Int) {
        //Simulating initial load of content
        for counter in (repos.count-count)..<(repos.count) {
            //Simulating slow download using large images
            var layla = NSMutableDictionary()
            repos[counter].getDisplayInfo(displayDict: &layla)
            let thumbnail = layla["layla4"] as! String
            let imageURL = URL(string: thumbnail)
            //if let imageURL = imageURL {
            imageURLs.append(imageURL ?? URL(string: "https://avatars1.githubusercontent.com/u/1961952?v=4")!)
            }
        
    }
    
    // MARK: Utilities for lazy loading of articles thumbnails
    func executeDownloadImageOperationBlock(for indexPath: IndexPath?) {
        let url: URL? = imageURLs[indexPath?.row ?? 0]
        let blockOperation = BlockOperation()
        weak var weakBlockOperation: BlockOperation? = blockOperation
        weak var weakSelf = self
        blockOperation.addExecutionBlock({
            if (weakBlockOperation?.isCancelled)! {
                if let url = url {
                    weakSelf?.operations[url] = nil
                }
                return
            }
            var imageData: Data? = nil
            if let url = url {
                imageData = try? Data(contentsOf: url)
            }
            var image: UIImage? = nil
            if let imageData = imageData {
                image = UIImage(data: imageData)
            }
            if let url = url {
                weakSelf?.images[url] = image
            }
            weakSelf?.operations[url!] = nil
            DispatchQueue.main.async(execute: {
                let visibleCellIndexPaths = weakSelf?.tableView.indexPathsForVisibleRows
                if let indexPath = indexPath {
                    if visibleCellIndexPaths!.contains(indexPath) {
                        let cell = weakSelf?.tableView.cellForRow(at: indexPath) as? MainCollectionViewCell
                        cell?.avatar!.image = image
                        cell?.avatar!.maskCircle(anyImage: image!)
                        cell?.activityIndicator.stopAnimating()
                    }
                }
            })
        })
        downloadImageOperationQueue?.addOperation(blockOperation)
        operations[url!] = blockOperation
        
    }
    func cancelDowloandImageOperationBlock(for indexPath: IndexPath?) {
        
        let imageURL: URL? = imageURLs[indexPath?.row ?? 0]
        if let imageURL = imageURL {
            if (operations[imageURL] != nil) {
                let blockOperation: BlockOperation? = (operations.object(forKey: imageURL) as! BlockOperation)
                blockOperation?.cancel()
                operations[imageURL] = nil
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITabBarDelegate,UITableViewDelegate{
    
    // MARK: <UITableViewDataSourcePrefetching>
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            
            // Updating upcoming CollectionView's data source. Not assiging any direct value
            // as this operation is expensive it is performed on a private queue
            let imageURL: URL? = imageURLs[indexPath.row]
            if let imageURL = imageURL {
                if (images[imageURL] == nil) {
                    executeDownloadImageOperationBlock(for: indexPath)
                    print("Prefetching data for indexPath: \(indexPath)")
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            //Unloading or data load operation cancellations should happend here
            let imageURL: URL? = imageURLs[indexPath.row]
            if let imageURL = imageURL {
                if (operations[imageURL] != nil) {
                    cancelDowloandImageOperationBlock(for: indexPath)
                    print("Unloading data fetch in progress for indexPath: \(indexPath)")
                }
            }
        }

    }
    
    // MARK: <UITableViewDataSource>
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MainCollectionViewCell
        var layla = NSMutableDictionary()
    if searchBarIsEmpty() {
        
    repos[indexPath.row].getDisplayInfo(displayDict: &layla)
        cell.repoTitleLabel.text = layla["layla1"] as! String
        cell.repoOwnerLabel.text = layla["layla2"] as! String
        cell.repoDescrpLabel.text = layla["layla3"] as! String
        let imageURL: URL? = imageURLs[indexPath.row]
        if let imageURL = imageURL {
            if (images[imageURL] != nil) {
                cell.avatar?.image = (images[imageURL] as! UIImage)
                cell.activityIndicator.stopAnimating()
            } else {
                executeDownloadImageOperationBlock(for: indexPath)
            }
        }
        if (indexPath.row == repos.count - 1) { // last cell
            currentPage += 1
            if (currentReposCount  < totalReposCount) { // more items to fetch
                getReposPerPage(pageNum: currentPage)
            }
        }
    }
    else {
searchdata[indexPath.row].getDisplayInfo(displayDict: &layla)
        cell.repoTitleLabel.text = layla["layla1"] as! String
        cell.repoOwnerLabel.text = layla["layla2"] as! String
        cell.repoDescrpLabel.text = layla["layla3"] as! String
        let imageURL: URL? = searchImageURLs[indexPath.row]
        if let imageURL = imageURL {
            var imageData: Data? = nil
            imageData = try? Data(contentsOf: imageURL)
            var image: UIImage? = nil
            if let imageData = imageData {
                image = UIImage(data: imageData)
            }
            cell.avatar?.image = image
            cell.activityIndicator.stopAnimating()
        }
    }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRepo = repos[indexPath.row]
        self.performSegue(withIdentifier: "webview", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if searchBarIsEmpty(){
                return repos.count
            } else {
                return searchdata.count
            }
    }
    
    // MARK: <UITableViewDelegate>
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cancelDowloandImageOperationBlock(for: indexPath)

    }
    
    func searchBarIsEmpty() -> Bool {
        return resultSearchController.searchBar.text?.isEmpty ?? true
    }

}
extension UIImageView {
  public func maskCircle(anyImage: UIImage) {
    self.contentMode = UIView.ContentMode.scaleAspectFill
    //self.layer.cornerRadius = self.frame.height / 2
    //self.layer.masksToBounds = false
    //self.clipsToBounds = true

   self.layer.borderWidth = 1.0
   self.layer.masksToBounds = false
   self.layer.borderColor = UIColor.white.cgColor
    self.layer.cornerRadius = self.frame.height / 2
   self.clipsToBounds = true
   self.image = anyImage
  }
}
