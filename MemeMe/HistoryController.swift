//
//  HistoryController.swift
//  MemeMe
//
//  Created by Nicholas Busby on 4/8/15.
//  Copyright (c) 2015 Nicholas Busby. All rights reserved.
//
//  This is a parent class for the two sent memes pages so that some of there functionality can be shared

import UIKit

class HistoryController: UIViewController {
    var memes: [Meme]!
    var appDelegate: AppDelegate!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //get all the memes then if there are 0 memes go directly to the meme Maker
        fillMemes()
        if(memes.count<1){
            newMeme()
        }
    }
    
    func fillMemes(){
        //pull memes from the AppDelegate
        let object = UIApplication.sharedApplication().delegate
        appDelegate = object as AppDelegate
        memes = appDelegate.memes
        appDelegate.starting = false
    }
    
    func showMemeDetail(){
        // facad to hid the complexity of this segue
        navigationController?.navigationController?.performSegueWithIdentifier("memeDetail", sender: nil)
    }
    
    func newMeme(){
        // facad to hid the complexity of this segue
        navigationController?.navigationController?.performSegueWithIdentifier("makeAMeme", sender: self)
    }
    
}

