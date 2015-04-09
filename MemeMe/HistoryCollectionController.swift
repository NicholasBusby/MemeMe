//
//  HistoryCollectionController.swift
//  MemeMe
//
//  Created by Nicholas Busby on 4/7/15.
//  Copyright (c) 2015 Nicholas Busby. All rights reserved.
//

import UIKit

class HistoryCollectionController: HistoryController, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //set the collection view to use this class for its functionality
        collectionView.delegate = self
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("memeCell", forIndexPath: indexPath) as MemeTileController
        let meme = self.memes[indexPath.row]
        
        //set the image
        cell.image.image = meme.memedImage
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //on selected show the meme detail
        appDelegate.meme = memes[indexPath.row]
        showMemeDetail()
    }
}