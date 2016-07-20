//
//  DataService.swift
//  My-Hood
//
//  Created by Zachary Blaustone on 7/19/16.
//  Copyright © 2016 Pryzm. All rights reserved.
//



import Foundation
import UIKit

// This is a singleton. A Singleton is used globaly throughout the app to save date. Here we are saving it into a veriable.

class DataService {
    // static is saying only ever make one instance of this
    static let instance = DataService()
        // We made this variable just because we started using "posts" to many times and didnt want to repeat ourselves.
    let KEY_POSTS = "posts"
    
    private var _loadedPosts = [Post]()
    
    var loadedPosts: [Post] {
        return _loadedPosts
    }
    
    func savePosts() {
            // We are taking our array and turning it into data
        let postsData = NSKeyedArchiver.archivedDataWithRootObject(_loadedPosts)
                // standardUserDefaults are a storage mechanism. And were setting an object and giving it a key. Kinda like a dictionary but for data.
        NSUserDefaults.standardUserDefaults().setObject(postsData, forKey: KEY_POSTS)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func loadPosts() {
            // We are going to our standardUserDefaults and saying we want an object for a key.
       if let postsData = NSUserDefaults.standardUserDefaults().objectForKey(KEY_POSTS) as? NSData {
                // We grabbed the data and put it into a variable as? the [Post] Array
            if let postsArray = NSKeyedUnarchiver.unarchiveObjectWithData(postsData) as? [Post] {
                _loadedPosts = postsArray
            }
        }
        // All were doing is saying when the posts have loaded lets go ahead and call our default notification center and posting a natification making it a new notification and giving it a name
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "postsLoaded", object: nil))
    }
    
        // This is the code to save an image as a path
    func saveImageAndCreatePath(image: UIImage) -> String {
        let imgData = UIImagePNGRepresentation(image)
        let imgPath = "image\(NSDate.timeIntervalSinceReferenceDate()).png"
        let fullPath = documentsPathForFileName(imgPath)
        imgData?.writeToFile(fullPath, atomically: true)
        return imgPath
    }
    
    func imageForPath(path: String) -> UIImage? {
        let fullPath = documentsPathForFileName(path)
        let image = UIImage(named: fullPath)
        return image
    }
    
    func addPost(post: Post) {
        _loadedPosts.append(post)
        savePosts()
        loadPosts()
    }
    
        // NSSearchPathForDirectoriesInDomains is a Documents directory where you store images
        // We are grabbing the path to the image and appending the path to the end of the .DocumentDirectory
    func documentsPathForFileName(name: String) -> String {
                                                                            // This is your personal directory
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let fullPath = paths[0] as NSString
        return fullPath.stringByAppendingPathComponent(name)
        
    }
}








