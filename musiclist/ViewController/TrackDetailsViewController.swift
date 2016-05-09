//
//  TrackDetailsViewController.swift
//  musiclist
//
//  Created by Artem Shuba on 09/05/16.
//  Copyright © 2016 ashuba. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class TrackDetailsViewController : UIViewController {
    
    @IBOutlet weak var coverImageView: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var artistLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var track: Track?
    
    override func viewDidLoad() {
        
        coverImageView.image = track?.getCoverImage()
        
        titleLabel.text = track?.title
        artistLabel.text = track?.artist
        
        if let path = NSBundle.mainBundle().pathForResource("description", ofType: "txt")
        {
            do {
                try descriptionLabel.text = String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
            }
            catch {
                descriptionLabel.text = nil
                
                print(error)
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBar.translucent = false
    }
    
    override func viewWillDisappear(animated: Bool) {
         navigationController?.navigationBar.translucent = true
    }
    
}