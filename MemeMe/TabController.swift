//
//  TabController.swift
//  MemeMe
//
//  Created by Nicholas Busby on 4/8/15.
//  Copyright (c) 2015 Nicholas Busby. All rights reserved.
//

import UIKit

class TabController: UITabBarController {
    
    @IBAction func newMeme(sender: AnyObject) {
        //this is for when the user clicks the + button allowing them to make a new meme
        navigationController?.performSegueWithIdentifier("makeAMeme", sender: self)
    }
}
