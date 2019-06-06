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
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //preparing Core Data stuff
        
        managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let entityDescription = NSEntityDescription.entity(forEntityName: "Track", in: self.managedObjectContext)
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TrackSegue" {
            let cell = sender as! UITableViewCell
            let track = fetchedResultsController?.object(at: self.tableView.indexPath(for: cell)!) as! Track
            let vc = segue.destination as! TrackDetailsViewController
            vc.track = track
        }
    }
    
    //MARK: UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController?.fetchedObjects?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath) as! TrackCell
        
        let track = fetchedResultsController?.object(at: indexPath) as! Track
        cell.track = track

        return cell
    }
}
