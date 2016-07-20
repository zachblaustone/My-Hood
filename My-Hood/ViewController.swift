//
//  ViewController.swift
//  My-Hood
//
//  Created by Zachary Blaustone on 7/19/16.
//  Copyright © 2016 Pryzm. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // We had a variable array called [Posts] here, but now that we made the DataService we just started grabbing the same information from DataService.instance.loadedPosts.
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            // WE called the NSNotificationCenter a said we want to listen for this notification "postsLoaded" and when ever it is call this function "onPostsLoaded"
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onPostsLoaded:", name: "postsLoaded", object: nil)
        
// The UITableViewDelegate is always looking for something to deligate. So we set it to delegate self which is telling the table view that we the view controller is the delegate. And same thing with the data source.
        tableView.delegate = self
        tableView.dataSource = self
        DataService.instance.loadPosts()
// You will get an error on the ViewController becuase it will be looking for the functions of the delegate and data.
    }
// This is how many sections we want in the table view
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
// This is saying you want a cell of data eachtime a row appears on the screen
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let post = DataService.instance.loadedPosts[indexPath.row]
        
        // This is telling the table view to use one of the cells you have already created, so it can resue it. But it will give us a tableView cell so we need to cast it as? a PostCell
        if let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as? PostCell {
            cell.configureCell(post)
            return cell
        } else {
            let cell  = PostCell()
            cell.configureCell(post)
            return cell
        }
        
    }
// The table wants to know the height of your cell
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 83.0
    }
// This is saying how many rows we would like in each section, which at this point we havnt made yet so we need to make some variables. We made a veriable called posts and set it to an array of our class Posts. Now we set the rows to only be the amount of posts that are in the array.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.loadedPosts.count
    }
    
    func onPostsLoaded(notif: AnyObject) {
        // Any to add data to a table source you want to reload the tableView.
        tableView.reloadData()
    }
}

