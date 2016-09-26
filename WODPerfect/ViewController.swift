//
//  ViewController.swift
//  WODPerfect
//
//  Created by James Pacheco on 8/25/16.
//  Copyright © 2016 James Pacheco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func generateWodButtonTapped(sender: AnyObject) {
        let factory = WorkoutFactory()
        factory.getWorkout()
    }

}

