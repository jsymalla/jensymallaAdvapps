//
//  FirstViewController.swift
//  Lab1
//
//  Created by Jennifer Symalla on 1/27/16.
//  Copyright © 2016 Jennifer Symalla. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    let zoneComponent = 0
    let plantComponent = 1
    var regionalPlants : [String : [String]]!//dictionary
    var zones : [String]!
    var plants :[String]!
    
    
    @IBOutlet weak var plantPicker: UIPickerView!

    @IBOutlet weak var zoneLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path = NSBundle.mainBundle().pathForResource("plantzones", ofType: "plist")
        regionalPlants = NSDictionary(contentsOfFile: path!) as! [String : [String]]
        zones = Array(regionalPlants.keys)
        plants = regionalPlants[zones[0]]! as [String]
    }
    
    //Required for the UIPickerViewDataSource protocol
    //func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    //    return 2 //two components
    //}
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2 //number of components
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == zoneComponent{
            return zones.count
        }else {
                return plants.count
        }
    }
    
    //Picker Delegate methods
    //Returns the title for a given row
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //checks which component was picked and returns the value for the requested component
        if component == zoneComponent{
            return zones[row]
        }else{
        return plants[row]
        }
    }
    
    //Called when a row is selected
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //checks which component was picked
        if component == zoneComponent{
            let selectedZone = zones[row] //gets the selected zone
            plants = regionalPlants[selectedZone]// gets the plant sfor the selected zone
            plantPicker.reloadComponent(plantComponent) //reload th ezone componenet
            plantPicker.selectRow(0, inComponent: plantComponent, animated: true)//sets album component back to 0
        }
        let zonerow = pickerView.selectedRowInComponent(zoneComponent) //gets selected row for zone
        let plantrow = pickerView.selectedRowInComponent(plantComponent) //gets selected row for plant
        zoneLabel.text = "The \(plants[plantrow]) + grows best in \(zones[zonerow])."
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

