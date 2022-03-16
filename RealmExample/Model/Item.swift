//
//  Item.swift
//  RealmExample
//
//  Created by Simon Berner on 16.03.22.
//

import Foundation
import RealmSwift

// In RealmSwift we have to define our models as class
class Item: Object, ObjectKeyIdentifiable {

    // primary database key of the object
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name = "test"
    @Persisted var isFavorite = false

    // backlink to the list of items of a group (to know to wich group an item belongs to)
    @Persisted(originProperty: "items") var group: LinkingObjects<Group>

}

let randomAdjectives = [
    "fluffy", "classy", "bumpy", "bizarre", "wiggly", "quick", "sudden",
    "acoustic", "smiling", "dispensable", "foreign", "shaky", "purple",
    "keen", "aberrant", "disastrous", "vague", "squealing", "ad hoc", "sweet"
]

let randomNouns = [
    "floor", "monitor", "hair tie", "puddle", "hair brush", "bread",
    "cinder block", "glass", "ring", "twister", "coasters", "fridge",
    "toe ring", "bracelet", "cabinet", "nail file", "plate", "lace",
    "cork", "mouse pad"
]
