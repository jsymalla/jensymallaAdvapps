//
//  DetailViewController.swift
//  Lab3_weekly_planner
//
//  Created by Jennifer Symalla on 2/15/16.
//  Copyright © 2016 Jennifer Symalla. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    
    var activities = [String]()
    var selectedDay = 0
    var plannerListDetail = Myweek()
    
    @IBAction func unwindSegue (segue:UIStoryboardSegue) {
        if segue.identifier == "doneSegue" {
            let source = segue.sourceViewController as! AddActivityViewController
            //only add an activity if there's text in the field
            if ((source.addedActivity.isEmpty) == false){
                activities.append(source.addedActivity)
                tableView.reloadData()
                let chosenDay = plannerListDetail.weeks[selectedDay]
                plannerListDetail.plannerData[chosenDay]?.append(source.addedActivity)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        plannerListDetail.weeks = Array(plannerListDetail.plannerData.keys)
        let chosenDay = plannerListDetail.weeks[selectedDay]
        activities = plannerListDetail.plannerData[chosenDay]! as [String]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return activities.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath)
        cell.textLabel?.text=activities[indexPath.row]
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            //Delete activity from array
            activities.removeAtIndex(indexPath.row)
            let chosenDay = plannerListDetail.weeks[selectedDay]
            //delete from the data model
            plannerListDetail.plannerData[chosenDay]?.removeAtIndex(indexPath.row)
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

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
