//
//  HistoryController.swift
//  MemeMe
//
//  Created by Nicholas Busby on 4/8/15.
//  Copyright (c) 2015 Nicholas Busby. All rights reserved.
//

import UIKit
import Foundation

class HistoryController: UIViewController {
    var memes: [Meme]!
    var appDelegate: AppDelegate!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        fillMemes()
        if(memes.count<1){
            navigationController?.navigationController?.performSegueWithIdentifier("makeAMeme", sender: self)
        }
    }
    
    func fillMemes(){
        let object = UIApplication.sharedApplication().delegate
        appDelegate = object as AppDelegate
        memes = appDelegate.memes
        appDelegate.starting = false
    }
    
    func showMemeDetail(){
        navigationController?.navigationController?.performSegueWithIdentifier("memeDetail", sender: nil)
    }
    
    func newMeme(){
        navigationController?.navigationController?.performSegueWithIdentifier("makeAMeme", sender: self)
    }
    
}

