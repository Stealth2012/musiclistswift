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
    @IBOutlet private weak var coverImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var artistLabel: UILabel!
    
    var track: Track? {
        didSet {
            update()
        }
    }
    
    private func update() {
        guard let track = self.track else { return }
        
        titleLabel.text = track.title
        artistLabel.text = track.artist
        
        coverImageView.image = track.getCoverImage()
    }
}
