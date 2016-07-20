//
//  AddPostVC.swift
//  My-Hood
//
//  Created by Zachary Blaustone on 7/19/16.
//  Copyright © 2016 Pryzm. All rights reserved.
//

import UIKit

                                    // We needed to add the UIImagePickerControllerDelegate so that we could use the UIImagePickerController, but the UIImagePickerControllerDelegate doesnt work unless you have the UINavigationControllerDelegate. So we added that as well.
class AddPostVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var titleFeild: UITextField!
    @IBOutlet weak var descriptionFeild: UITextField!
    
    // This is what we need to save an image (UIImagePickerController)
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // This is making the image a circle
        postImg.layer.cornerRadius = postImg.frame.size.width / 2
        postImg.clipsToBounds = true
                            // This is just initionalizing the imagePicker to the UIImagePickerController
        imagePicker = UIImagePickerController()
            // We are setting the imagePicker to delegate from self so that it works with this class
        imagePicker.delegate = self
    }
    @IBAction func makePostBtnPressed(sender: AnyObject) {
            // All this is doing is making sure that before we go and save anything all the information we want to save is actually there. i.e (title, description, image)
        if let title = titleFeild.text, let desc = descriptionFeild.text, let img = postImg.image {
            
            let imgPath = DataService.instance.saveImageAndCreatePath(img)
            
            // We just made this mock post so we can start saving
            let post = Post(imagepath: imgPath, title: title, description: desc)
                        // Called the DataService class .instance.addpost and added a post
            DataService.instance.addPost(post)
            dismissViewControllerAnimated(true, completion: nil)
        }

    }
    @IBAction func CancelBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func addPicBtnPressed(sender: UIButton!) {
        sender.setTitle("", forState: .Normal)
                            //imagePicker is apples viewController
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
        // This function listens for saving an image
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
            //When the user selects an image we want to hide the image picker
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        postImg.image = image
    }
}
















