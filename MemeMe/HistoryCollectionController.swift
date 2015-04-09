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
        cell.image.image = meme.memedImage
        cell.selected = false
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        appDelegate.meme = memes[indexPath.row]
        showMemeDetail()
    }
}