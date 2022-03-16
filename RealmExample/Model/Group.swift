//
//  Group.swift
//  RealmExample
//
//  Created by Simon Berner on 16.03.22.
//

import Foundation
import RealmSwift

final class Group: Object, ObjectKeyIdentifiable {

    @Persisted(primaryKey: true) var _id: ObjectId

    // to-many-relationship (a group has a list of items)
    @Persisted var items = RealmSwift.List<Item>()


}
