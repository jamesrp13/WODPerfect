//
//  WODTableViewController.swift
//  WODPerfect
//
//  Created by James Pacheco on 8/25/16.
//  Copyright © 2016 James Pacheco. All rights reserved.
//

import UIKit

class WODTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ExerciseCell", forIndexPath: indexPath)

        cell.textLabel?.text = "Hi, this is a test!"

        return cell
    }

}
