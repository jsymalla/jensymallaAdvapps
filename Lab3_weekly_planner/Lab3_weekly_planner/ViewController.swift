//
//  ViewController.swift
//  Lab3_weekly_planner
//
//  Created by Jennifer Symalla on 2/15/16.
//  Copyright © 2016 Jennifer Symalla. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var weekList = Myweek()
    let kfilename = "data.plist"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //let path = NSBundle.mainBundle().pathForResource("planner", ofType: "plist")
        //weekList.plannerData = NSDictionary(contentsOfFile: path!) as! [String: [String]]
        //weekList.weeks = Array(weekList.plannerData.keys)
        
        let path:String?
        let filePath = docFilePath(kfilename)
        
        //if the data file exists, use it
        if NSFileManager.defaultManager().fileExistsAtPath(filePath!){
            path = filePath
            print(path)
        }else{
            path = NSBundle.mainBundle().pathForResource("planner", ofType: "plist")
            print(path)
        }
        
        //load the data of the plist file into the dictionary
        weekList.plannerData = NSDictionary(contentsOfFile: path!) as! [String :[String]]
        //puts all the continents in an array
        weekList.weeks = Array(weekList.plannerData.keys)
        
        //application instance
        let app = UIApplication.sharedApplication()
        //subscribe to the UIApplicationWillResignActiveNotification notification
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillResignActive", name: "UIApplicationWillResignActiveNotification", object: app)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "activitysegue"{
            let detailVC = segue.destinationViewController as! DetailViewController
            let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)!
            //set the data for the destination controller
            detailVC.title = weekList.weeks[indexPath.row]
            detailVC.plannerListDetail = weekList
            detailVC.selectedDay = indexPath.row
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weekList.plannerData.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //make the plist appear in the order it is type (not quite sur ehow to implent this)
        // referenced article:stackoverflow.com/questions/12996493/why-do-strings-from-plist-not-display-in-correct-order-in-a-uitableview
        //NSArray *keys = [[String: [string] allKeys] sortedArrayUsingSelector:@selector(compare:)]
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath)
        cell.textLabel?.text = weekList.weeks[indexPath.row]
        return cell
    }
    
    func docFilePath(filename: String) -> String? {
        //locate document directory
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)
        let dir = path[0] as NSString
        return dir.stringByAppendingPathComponent(filename)
    }
    
    //called when the UIApplicationWillResignActiveNotification notification is posted
    //all notification methods take a single NSNotification instance as their argument
    func applicationWillResignActive(notification: NSNotification){
        let filePath = docFilePath(kfilename)
        let data = NSMutableDictionary()
        //adds our whole dictionary to the data dictionary
        data.addEntriesFromDictionary(weekList.plannerData)
        print(data)
        //write the contents of the array to our plist file
        data.writeToFile(filePath!, atomically: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

