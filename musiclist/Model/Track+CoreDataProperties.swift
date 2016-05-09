//
//  Track+CoreDataProperties.swift
//  musiclist
//
//  Created by Artem Shuba on 09/05/16.
//  Copyright © 2016 ashuba. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData
import UIKit

extension Track {

    @NSManaged var artist: String?
    @NSManaged var coverId: String?
    @NSManaged var id: Int32
    @NSManaged var title: String?

    func getCoverImage() -> UIImage? {
        if let coverId = self.coverId {
            return UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource(coverId, ofType: nil)!)
        }
        
        return nil
    }
}
