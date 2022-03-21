//
//  ItemDetailView.swift
//  RealmExample
//
//  Created by Simon Berner on 16.03.22.
//

import SwiftUI
import RealmSwift

struct ItemDetailView: View {

    // live realm data object (has always the current data)
    @ObservedRealmObject var item: Item

    // get the default realm object to access the database
//    @Environment(\.realm) var realm
//    @Environment(\.realmConfiguration) var realmConfig

    var body: some View {
        VStack(alignment: .leading) {
            Text("Enter a new name:")

            TextField("New name", text: $item.name)
                .textFieldStyle(.roundedBorder)
                .navigationTitle(item.name)
                .navigationBarItems(trailing: Toggle(isOn: $item.isFavorite, label: {
                    Image(systemName: item.isFavorite ? "heart.fill" : "heart")
                }))
            Button {
                // .thaw(): return a live mutable reference of this object
                // .realm: each object knows to which realm database it belongs to
                if let newItem = item.thaw(), let realm = newItem.realm {
                    // write transaction
                    do {
                        try realm.write {
                            realm.delete(newItem)
                         }
                    } catch {
                        // TODO: show alert
                        print(error.localizedDescription)
                    }
                }

            } label: {
                Text("delete")
            }
            .padding()
        }
        .padding()
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ItemDetailView(item: Item.previewExample())
        }
    }
}
