//
//  MemeDetail.swift
//  MemeMe
//
//  Created by Nicholas Busby on 4/8/15.
//  Copyright (c) 2015 Nicholas Busby. All rights reserved.
//

import UIKit

class MemeDetail: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        //get the meme and display it
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as AppDelegate
        imageView.image = appDelegate.meme.memedImage
    }
    
}
