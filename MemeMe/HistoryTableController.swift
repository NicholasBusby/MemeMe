//
//  historyTable.swift
//  MemeMe
//
//  Created by Nicholas Busby on 4/7/15.
//  Copyright (c) 2015 Nicholas Busby. All rights reserved.
//

import UIKit

class HistoryTableController: HistoryController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //get the table view to call on this for its functionality
        tableView.delegate = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("memeCell") as UITableViewCell
        let meme = self.memes[indexPath.row]
        
        // Set the text and image
        cell.textLabel?.text = meme.topText + " " + meme.bottomText
        cell.imageView?.image = meme.memedImage
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //on click call the meme detail
        appDelegate.meme = memes[indexPath.row]
        showMemeDetail()
    }
    
    
}