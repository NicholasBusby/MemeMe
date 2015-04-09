//
//  meme.swift
//  MemeMe
//
//  Created by Nicholas Busby on 4/6/15.
//  Copyright (c) 2015 Nicholas Busby. All rights reserved.
//

import Foundation
import UIKit

class Meme: NSObject, UIActivityItemSource {
    var topText: String = ""
    var bottomText: String = ""
    var originalImage: UIImage?
    var memedImage: UIImage?
    
    func activityViewControllerPlaceholderItem(activityViewController: UIActivityViewController) -> AnyObject {
        return ""
    }
    
    func activityViewController(activityViewController: UIActivityViewController, itemForActivityType activityType: String) -> AnyObject? {
        return self
    }
}