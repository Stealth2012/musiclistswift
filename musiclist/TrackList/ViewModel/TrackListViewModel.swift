//
//  TrackListViewModel.swift
//  musiclist
//
//  Created by Artem Shuba on 06/06/2019.
//  Copyright © 2019 ashuba. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class TrackListViewModel : BindableObject {
    private let tracksDataStore: TracksDataStore
    
    let didChange = PassthroughSubject<TrackListViewModel, Never>()
    
    var tracks: [Track] = [] {
        didSet {
            didChange.send(self)
        }
    }
    
    var tracksUpdated: (() -> Void)?
    
    init(dataStore: TracksDataStore) {
        self.tracksDataStore = dataStore
        
        load()
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
