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
    private var viewModel: TrackListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = TrackListViewModel(dataStore: TracksDataStore(CoreDataStore()))
        viewModel?.tracksUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
        
        tableView.dataSource = self
        
        viewModel?.load()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TrackSegue" {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)!
            let track = viewModel?.tracks[indexPath.row]
            let vc = segue.destination as! TrackDetailsViewController
            vc.track = track
        }
    }
    
    //MARK: UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.tracks.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath) as! TrackCell
        
        let track = viewModel?.tracks[indexPath.row]
        cell.track = track

        return cell
    }
}
