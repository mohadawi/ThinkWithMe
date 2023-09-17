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
    var downloadImageOperationQueue: OperationQueue? = OperationQueue()
    var operations = NSMutableDictionary()
    var images = NSMutableDictionary()
    var repos = /*[Repository]*/[Item]()// holds the guardian articles we want to list
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
    var resultSearchController = UISearchController()
    
    // MARK: Search Bar delegate functions
    func updateSearchResults(for searchController: UISearchController) {
        reload()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        baseUrl = " search?&api-key=19a3c46d-c355-40fa-b9b9-5b2893b34c1c&show-fields=starRating,thumbnail"
        currentPage = 1
        repos.removeAll()
        self.tableView.reloadData()
        getReposPerPage(pageNum: currentPage)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // to limit network activity, reload half a second after last key press.
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(ViewController.reload), object: nil)
        self.perform(#selector(self.reload), with: nil, afterDelay: 0.5)
    }
    
    // reload the data when search text cahnges
    @objc func reload() {
        baseUrl = "https://content.guardianapis.com/search?q=" + resultSearchController.searchBar.text! + "&api-key=302fe17b-9a43-4cf7-aa7c-2bf80a89dc8c&show-fields=starRating,thumbnail"
        currentPage = 1
        repos.removeAll()
        self.tableView.reloadData()
        if(resultSearchController.searchBar.text! != ""){
            getReposPerPage(pageNum: currentPage)
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
        guard let eyesColorTemplate = TextFieldTemplate(fId: "TF1",fLabel: "eyes color",desiredValues: ["Blue","Brown"])
            else {
                return
        }
        guard let nameTemplate = TextFieldTemplate(fId: "TF2",fLabel: "Name")
            else {
                return
        }
        
        
        //create a girl template and add the above fields
        var girlTemplate=GirlTemplate(tID: "GTmpl1")
        girlTemplate.addFieldTemplate(fTemplate: nameTemplate)
        girlTemplate.addFieldTemplate(fTemplate: eyesColorTemplate)
        
        //Now create an instance of girlTemplate who has a name rasha and eyes color blue
        //same logic. create the text fields first
        //Name Text Field
        guard let rashaName = TextField(fieldTmpId: nameTemplate.getID(), fieldTmpLabel: nameTemplate.getLabel(),val: "Rasha")
            else {
                return
        }
        //Eyes Color Text Field
        guard let rashaEyesColor = TextField(fieldTmpId: eyesColorTemplate.getID(), fieldTmpLabel: eyesColorTemplate.getLabel(), val: "Blue")
            else {
                return
        }
        //create the girl's instance
        let rasha = Girl(templID: girlTemplate.getID())
        rasha.addField(field: rashaName)
        rasha.addField(field: rashaEyesColor)
        
        //Sally instance info
        //Name Text Field
        guard let sallyName = TextField(fieldTmpId: nameTemplate.getID(), fieldTmpLabel: nameTemplate.getLabel(),val: "Sally")
            else {
                return
        }
        //Eyes Color Text Field
        guard let sallyEyesColor = TextField(fieldTmpId: eyesColorTemplate.getID(), fieldTmpLabel: eyesColorTemplate.getLabel(),val: "Brown")
            else {
                return
        }
        
        //create the girl's instance
        let sally = Girl(templID: girlTemplate.getID())
        sally.addField(field: sallyName)
        sally.addField(field: sallyEyesColor)
        
        //Soha info
        //Name Text Field
        guard let sohaName = TextField(fieldTmpId: nameTemplate.getID(), fieldTmpLabel: nameTemplate.getLabel(),val: "Soha")
            else {
                return
        }
        //Eyes Color Text Field
        guard let sohaEyesColor = TextField(fieldTmpId: eyesColorTemplate.getID(), fieldTmpLabel: eyesColorTemplate.getLabel(),val: "Black")
            else {
                return
        }
        
        //create the girl's instance
        let soha = Girl(templID: girlTemplate.getID())
        soha.addField(field: sohaName)
        soha.addField(field: sohaEyesColor)
        
        
        var myCrushesEyes = [rasha.eyesColor,sally.eyesColor,soha.eyesColor]
        var eyesColor = [Field]()
        eyesColor.append(rasha.eyesColor ?? rashaEyesColor)
        eyesColor.append(sally.eyesColor ?? rashaEyesColor)
        eyesColor.append(soha.eyesColor ?? rashaEyesColor)
        
        var myCrushes = [rasha,sally,soha]
        
        
        // create a composited rule ( The hard thing is that how do we create this rule in the template!!
        var c1 = CompositeRule()
        guard let eColor = ValueInListRule(fT: eyesColorTemplate)
            else {
                return
        }
        
        //c1 = blueEyes.And(other: greenEyes).And(other: brownEyes) as! CompositeRule
        //let c = c1.isSatisfiedBy(field: f1)
        
        
        //Get the fields to filter the crushes on
        
        //create a filter for the fields
        
        var eyesFilter = FilterFields.filterFieldsBy(rule: eColor, fields: eyesColor)
        
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
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRepo = repos[indexPath.row]
        self.performSegue(withIdentifier: "webview", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.repos.count
    }
    
    // MARK: <UITableViewDelegate>
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cancelDowloandImageOperationBlock(for: indexPath)

    }

}

