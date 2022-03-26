//
//  ItemListView.swift
//  RealmExample
//
//  Created by Simon Berner on 16.03.22.
//

import SwiftUI
import RealmSwift

struct ItemListView: View {
    
    // Realm property wrapper which redraws the view upon changes
    @ObservedRealmObject var group: Group

    var body: some View {
        NavigationView {
            List {
                ForEach(group.items) { item in
                    ItemRowView(item: item)
                }
                .onMove(perform: $group.items.move)
                // SwiftUI passes a set of indices to the closure that’s relative to the dynamic view’s underlying collection of data.
                .onDelete(perform: { indexSet in

                    // first index is the one of the to be deleted item
                    if let index = indexSet.first {
                        let item = group.items[index]
                        $group.items.remove(atOffsets: indexSet)

                        if let item = item.thaw(), let realm = item.realm {
                            try? realm.write({
                                realm.delete(item)
                            })
                        }
                    }
                })
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Items", displayMode: .large)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(trailing: EditButton())
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Log out") {
                        AuthenticationManager.logout()
                    }
                }

                ToolbarItem(placement: .bottomBar) {
                    Button {
                        $group.items.append(Item())
                    } label: {
                        Image(systemName: "plus")
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
        }
    }
}

struct ItemRowView: View {

    @ObservedRealmObject var item: Item

    var body: some View {
        NavigationLink(destination: ItemDetailView(item: item)) {
            Text(item.name)
            if item.isFavorite {
                Image(systemName: "heart.fill")
            }
        }

    }
}

struct ItemListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListView(group: Group())
    }
}
