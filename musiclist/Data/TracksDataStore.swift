//
//  TracksDataStore.swift
//  musiclist
//
//  Created by Artem Shuba on 06/06/2019.
//  Copyright © 2019 ashuba. All rights reserved.
//

import Foundation

class TracksDataStore {
    private let coreDataStore: CoreDataStore
    
    init(_ coreDataStore: CoreDataStore) {
        self.coreDataStore = coreDataStore
    }
    
    func fetchAll(complete: (Result<[Track], Error>) -> Void) {
        let sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        let result: Result<[Track], Error> = coreDataStore.fetchAll(sortDescriptors: sortDescriptors)
        complete(result)
    }
}
