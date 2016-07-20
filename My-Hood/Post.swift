//
//  Post.swift
//  My-Hood
//
//  Created by Zachary Blaustone on 7/19/16.
//  Copyright © 2016 Pryzm. All rights reserved.
//

import Foundation

            // If you want to archive or unarchive you need to inherate from NSObject, and NSCoding

class Post: NSObject, NSCoding {
    
    private var _imagepath: String!
    private var _title: String!
    private var _postDesc: String!
    
    var imagepath: String {
        return _imagepath
    }
    
    var title: String {
        return _title
    }
    
    var postDesc: String {
        return _postDesc
    }
    
    init(imagepath: String, title: String, description: String) {
        self._imagepath = imagepath
        self._title = title
        self._postDesc = description
    }
    
    override init() {
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        
            // We are grabbing the image path and saying when something is unarchiving you decode it first from "imagepath"
        self._imagepath = aDecoder.decodeObjectForKey("imagePath") as? String
        self._title = aDecoder.decodeObjectForKey("title") as? String
        self._postDesc = aDecoder.decodeObjectForKey("description") as? String
    }
            // This is a function to encode. When ever it's saving it will call this function.
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self._imagepath, forKey: "imagePath")
        aCoder.encodeObject(self._title, forKey: "title")
        aCoder.encodeObject(self._postDesc, forKey: "description")
    }
}
