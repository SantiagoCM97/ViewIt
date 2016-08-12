//
//  TVShowSearchTableController.swift
//  ViewIt
//
//  Created by Santiago Castaño M on 7/20/16.
//  Copyright © 2016 Santiago Castano. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class TVShowSearchTableController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    var searchController:UISearchController!
    var searchedShows: [tvShow] = []
    var filteredsearchedShows: [tvShow] = []
    var shouldShowSearchResults: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("1. view loaded")
        configureSearchController()
        print("2. search controller configured")
        
        Alamofire.request(.GET, tvShow.urlForPopularShows())
            .responseJSON { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling GET on /todos/1")
                    print(response.result.error!)
                    return
                }
                
                if let value = response.result.value {
                    print("value was declared? LOL")
                    // handle the results as JSON, without a bunch of nested if loops
                    let parsedData = JSON(value)
                   
                    // now we have the results, let's just print them though a tableview would definitely be better UI:
                    for show in parsedData["results"].arrayValue {
                        let name = show["name"].stringValue
                        let summary = show["overview"].stringValue
                        let idNumber = show["id"].intValue
                        let premiered = show["first_air_date"].stringValue
                        let premieredYear = premiered[premiered.startIndex..<premiered.endIndex.advancedBy(-6)]
                        
                        let showResult = tvShow(name: name, idNumber: idNumber, summary: summary, premiered: premieredYear)
                        print("Name is: \(name)")
                        self.searchedShows.append(showResult)
                    }
                    }
                self.shouldShowSearchResults = true
                print("Working")
                self.tableView.reloadData()
            }
                
        }
       
    
    
   
    // MARK: - Table view data source
    
    
    func configureSearchController() {
        // Initialize and perform a minimum configuration to the search controller.
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        
        // Place the search bar view to the tableview headerview.
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        shouldShowSearchResults = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        shouldShowSearchResults = false
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tableView.reloadData()
        }
        
        searchController.searchBar.resignFirstResponder()
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        
        // Filter the data array and get only those countries that match the search text.
        self.filteredsearchedShows = self.searchedShows.filter({( aTvShow: tvShow) -> Bool in
            // to start, let's just search by name
            return aTvShow.name!.lowercaseString.rangeOfString(searchString!.lowercaseString) != nil
        })
        
        // Reload the tableview.
        tableView.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        shouldShowSearchResults = false
        if shouldShowSearchResults {
            return filteredsearchedShows.count
        }
        else {
            return searchedShows.count
        }
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("searchedTvShowCell") as! TvShowCellController
        shouldShowSearchResults = false

        if shouldShowSearchResults {
            cell.nameLbl?.text = filteredsearchedShows[indexPath.row].name
            cell.summaryLbl?.text = searchedShows[indexPath.row].summary
            cell.scheduleLbl?.text = "(\(searchedShows[indexPath.row].premiered!))"
        }
        else {
            
            cell.nameLbl?.text = searchedShows[indexPath.row].name
            cell.summaryLbl?.text = searchedShows[indexPath.row].summary
            cell.scheduleLbl?.text = "(\(searchedShows[indexPath.row].premiered!))"

        }
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
