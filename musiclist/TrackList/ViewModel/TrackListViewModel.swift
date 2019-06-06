//
//  TrackListViewModel.swift
//  musiclist
//
//  Created by Artem Shuba on 06/06/2019.
//  Copyright © 2019 ashuba. All rights reserved.
//

import Foundation

class TrackListViewModel {
    private let tracksDataStore: TracksDataStore
    
    var tracks: [Track] = [] {
        didSet {
            tracksUpdated?()
        }
    }
    
    var tracksUpdated: (() -> Void)?
    
    init(dataStore: TracksDataStore) {
        self.tracksDataStore = dataStore
    }
    
    func load() {
        tracksDataStore.fetchAll { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let tracks):
                    self.tracks = tracks
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
