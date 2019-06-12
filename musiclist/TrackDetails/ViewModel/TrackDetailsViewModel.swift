//
//  TrackDetailsViewModel.swift
//  musiclist
//
//  Created by Artem Shuba on 12/06/2019.
//  Copyright © 2019 ashuba. All rights reserved.
//

import Combine
import SwiftUI

class TrackDetailsViewModel : BindableObject {
    let didChange = PassthroughSubject<TrackDetailsViewModel, Never>()
    
    private(set) var track: Track {
        didSet {
            didChange.send(self)
        }
    }
    
    private(set) var description: String? = nil
    
    init(track: Track) {
        self.track = track
        
        guard let path = Bundle.main.path(forResource: "description", ofType: "txt") else { return }
        
        description = try? String(contentsOfFile: path, encoding: String.Encoding.utf8)
    }
}
