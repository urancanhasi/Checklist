//
//  ViewController.swift
//  Checklists
//
//  Created by Sebastien Arbogast on 26/08/2016.
//  Copyright © 2016 BusinessTraining. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
    var dataModel = [Checklist]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataModel.append(Checklist(withTitle:"Promener le chien"))
        dataModel.append(Checklist(withTitle:"Brosser mes dents"))
        dataModel.append(Checklist(withTitle:"Apprendre à développer une app"))
        dataModel.append(Checklist(withTitle:"M'entraîner pour le beer pong"))
        dataModel.append(Checklist(withTitle:"Dormir"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ChecklistViewController { //: UITableViewDataSource {
    override func tableView(tableView:UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.count
    }
    
    override func tableView(tableView:UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChecklistItem", forIndexPath: indexPath)
        
        let label = cell.viewWithTag(1000) as! UILabel
        let checklist = self.dataModel[indexPath.row]
        label.text = checklist.title
        cell.accessoryType = checklist.done ? .Checkmark : .None
        
        return cell
    }
}

extension ChecklistViewController { //: UITableViewDelegate {
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let checklist = self.dataModel[indexPath.row]
        checklist.done = !checklist.done
        
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }
}

