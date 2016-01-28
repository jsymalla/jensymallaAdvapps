//
//  SecondViewController.swift
//  Lab1
//
//  Created by Jennifer Symalla on 1/27/16.
//  Copyright © 2016 Jennifer Symalla. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBAction func plantZone(sender: UIButton) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.gurneys.com/zone_finder")!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

