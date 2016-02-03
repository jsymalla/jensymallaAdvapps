//
//  ViewController.swift
//  Lab2grouptableview
//
//  Created by Jennifer Symalla on 1/31/16.
//  Copyright © 2016 Jennifer Symalla. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var allcategories : [String : [String]]!
    var topics : [String]!
    var searchController : UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path = NSBundle.mainBundle().pathForResource("strange", ofType: "plist")
        allcategories = NSDictionary(contentsOfFile: path!) as! [String : [String]]
        topics = Array(allcategories.keys)
        topics.sortInPlace({$0 < $1})
        
        //for search bar
        let resultsController = SearchResultsController()
        resultsController.allcategories = allcategories
        resultsController.topics = topics
        searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchBar.placeholder = "Enter a search term"
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView=searchController.searchBar
        searchController.searchResultsUpdater = resultsController
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let topic = topics[section]
        let topicSection = allcategories[topic]! as [String]
        return topicSection.count
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let section = indexPath.section
        let topic = topics[section]
        let categorySection = allcategories[topic]! as [String]
    
        //configure the cell
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath) as UITableViewCell
    
        //set the text of the cell
        cell.textLabel?.text=categorySection[indexPath.row]
        return cell
    }
    
    //UITableViewDelegate method that is called when a row is selected
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let section = indexPath.section
        let topic = topics[section]
        let categorySection = allcategories[topic]! as [String]
        let alert = UIAlertController(title: "Row Selected", message: "\(categorySection[indexPath.row]) is a great thing to do or see in Denver.", preferredStyle: UIAlertControllerStyle.Alert)
        let okaction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(okaction)
        presentViewController(alert, animated: true, completion: nil)
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    //UITableViewDatasource methods
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return topics.count
    }
    
    //Sets the header value for each section
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return topics[section]
    }
    
    //adds a section index
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return topics
    }//errors out with [AnyObject]!
}


