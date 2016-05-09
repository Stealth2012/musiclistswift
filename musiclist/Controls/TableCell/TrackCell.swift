//
//  TrackCell.swift
//  musiclist
//
//  Created by Artem Shuba on 09/05/16.
//  Copyright © 2016 ashuba. All rights reserved.
//

import Foundation
import UIKit

class TrackCell: UITableViewCell {
    
    @IBOutlet weak var coverImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var artistLabel: UILabel!
    
    var track: Track? {
        didSet {
            titleLabel.text = track!.title
            artistLabel.text = track!.artist
            
            coverImageView.image = track!.getCoverImage()
        }
    }
}