//
//  RealmHelper.swift
//  RealmExample
//
//  Created by Simon Berner on 18.03.22.
//

import Foundation
import RealmSwift

final class RealmHelper {

    /**
     A in-memory Realm instance which represents a Realm database

     - Returns: an in-memory Realm instance
     */
    static func inMemoryRealm() -> Realm {
        var conf = Realm.Configuration.defaultConfiguration
        conf.inMemoryIdentifier = "preview"

        return try! Realm(configuration: conf)
    }

    /**
     A in-memory Realm instance with items

     - Returns: an in-memory Realm instance with either all available items or some dummy items
     */
    static func realmWithItems() -> Realm {

        let realm = inMemoryRealm()

        // get all the objects of type Item from the Realm database
        let allItems = realm.objects(Item.self)

        if allItems.count == 0 {
            try? realm.write({
                for _ in 0...9 {
                    realm.add(Item())
                }
            })
        }
        return realm
    }

}
