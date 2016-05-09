//
//  MainViewController.swift
//  musiclist
//
//  Created by Artem Shuba on 08/05/16.
//  Copyright © 2016 ashuba. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MainViewController: UITableViewController {
    
    var managedObjectContext: NSManagedObjectContext!
    var fetchedResultsController: NSFetchedResultsController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //preparing Core Data stuff
        
        managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let fetchRequest = NSFetchRequest()
        let entityDescription = NSEntityDescription.entityForName("Track", inManagedObjectContext: self.managedObjectContext)
        
        //sorting by id
        let idSortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        
        fetchRequest.entity = entityDescription
        fetchRequest.sortDescriptors = [idSortDescriptor]
        fetchRequest.fetchBatchSize = 20
       
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: "Music")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            try fetchedResultsController?.performFetch()
        }
        catch {
            abort()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "TrackSegue" {
            let cell = sender as! UITableViewCell
            let track = fetchedResultsController?.objectAtIndexPath(self.tableView.indexPathForCell(cell)!) as! Track
            let vc = segue.destinationViewController as! TrackDetailsViewController
            vc.track = track
        }
    }
    
    //MARK: UITableViewDataSource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController?.fetchedObjects?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TrackCell", forIndexPath: indexPath) as! TrackCell
        
        let track = fetchedResultsController?.objectAtIndexPath(indexPath) as! Track
        cell.track = track

        return cell
    }
}