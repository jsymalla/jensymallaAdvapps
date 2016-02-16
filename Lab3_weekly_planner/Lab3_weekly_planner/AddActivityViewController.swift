//
//  AddActivityViewController.swift
//  Lab3_weekly_planner
//
//  Created by Jennifer Symalla on 2/15/16.
//  Copyright © 2016 Jennifer Symalla. All rights reserved.
//

import UIKit

class AddActivityViewController: UIViewController {
    
    var addedActivity = String()

    @IBOutlet weak var activityTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "doneSegue" {
            //add an activity only if there's text in the field
            if ((activityTextfield.text?.isEmpty) == false){
                addedActivity = activityTextfield.text!
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
