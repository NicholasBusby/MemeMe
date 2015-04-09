//
//  ViewController.swift
//  MemeMe
//
//  Created by Nicholas Busby on 4/3/15.
//  Copyright (c) 2015 Nicholas Busby. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    //attach the outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    
    //this is used so we dont clear the screen after choosing an image
    var imageSelecterTookView = false
    
    var excludedShares = [
        UIActivityTypePostToWeibo,
        UIActivityTypePrint,
        UIActivityTypeAssignToContact,
        UIActivityTypeAddToReadingList,
        UIActivityTypePostToVimeo,
        UIActivityTypePostToTencentWeibo
    ]
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -1
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topText.delegate = self
        bottomText.delegate = self
    }
    
    override func viewDidDisappear(animated: Bool) {
        //if leaving for anything other then the image selecter clear the view
        if(!imageSelecterTookView){
            clearAndSetup()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        imageSelecterTookView = false
        setUpVisual()
        self.subscribeToKeyboardNotifications()
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        //get rid of subscriptions
        self.unsubscribeFromKeyboardNotifications()
    }
    
    func setUpVisual(){
        //this does all the attributes and setup for the screen
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        topText.defaultTextAttributes = memeTextAttributes
        bottomText.defaultTextAttributes = memeTextAttributes
        topText.textAlignment = NSTextAlignment.Center
        bottomText.textAlignment = NSTextAlignment.Center
    }
    
    func clearAndSetup(){
        //this makes sure everything is empty for the user to make a new meme
        imageView.image = nil
        topText.text = nil
        bottomText.text = nil
        topToolBar.hidden = true
        bottomToolBar.hidden = false
    }
    
    @IBAction func getImageFromCollection(sender: UIBarButtonItem) {
        //this prevents clearing the screen
        imageSelecterTookView = true
        buildImagePicker(UIImagePickerControllerSourceType.PhotoLibrary)
    }

    @IBAction func getImageFromCamera(sender: UIBarButtonItem) {
        //this prevents clearing the screen
        imageSelecterTookView = true
        buildImagePicker(UIImagePickerControllerSourceType.Camera)
    }
    
    func buildImagePicker(source: UIImagePickerControllerSourceType){
        //build an image picker and tell it to use the camera
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = source
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBAction func saveButtonClicked(sender: AnyObject) {
        //make the meme
        let meme = Meme()
        meme.topText = topText.text
        meme.bottomText = bottomText.text
        meme.originalImage = imageView.image!
        meme.memedImage = generateMemedImage()
        
        //build activity view
        let activityViewController = UIActivityViewController(activityItems: [meme], applicationActivities: nil)
        activityViewController.excludedActivityTypes = excludedShares
        //show the activity view
        self.presentViewController(activityViewController,
            animated: true, 
            completion: nil)
        
        //on completion of the activity view save meme and show sent memes
        activityViewController.completionHandler = {(activityType, completed:Bool) in
            if completed {
                self.saveMeme(meme)
                self.goToHistoryPage()
            }
            activityViewController.dismissViewControllerAnimated(true, completion: nil)
            return
        }
    }
    
    func goToHistoryPage(){
        performSegueWithIdentifier("showHistory", sender: nil)
    }
    
    func saveMeme(meme: Meme){
        //add the meme to the appDelegate
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as AppDelegate
        appDelegate.memes.append(meme)
    }
    
    @IBAction func cancelButtonClick(sender: AnyObject) {
        clearAndSetup()
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        //when image picker is done set up all things for finishing memes
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        topToolBar.hidden = false
        bottomToolBar.hidden = true
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        //if they cancel, just dismiss
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if(bottomText.isFirstResponder()){
            self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as NSValue
        return keyboardSize.CGRectValue().height
    }
    
    func generateMemedImage() -> UIImage
    {
        //hid the toolbars
        topToolBar.hidden = true
        bottomToolBar.hidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        topToolBar.hidden = false
        bottomToolBar.hidden = false
        
        return memedImage
    }
}

