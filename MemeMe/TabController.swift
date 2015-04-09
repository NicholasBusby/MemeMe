//
//  TabController.swift
//  MemeMe
//
//  Created by Nicholas Busby on 4/8/15.
//  Copyright (c) 2015 Nicholas Busby. All rights reserved.
//

import UIKit
import Foundation

class TabController: UITabBarController {
    
    @IBAction func newMeme(sender: AnyObject) {
        navigationController?.performSegueWithIdentifier("makeAMeme", sender: self)
    }
}
