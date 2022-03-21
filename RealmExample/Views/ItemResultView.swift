//
//  ItemResultView.swift
//  RealmExample
//
//  Created by Simon Berner on 18.03.22.
//

import SwiftUI
import RealmSwift

struct ItemResultView: View {

    @ObservedResults(Item.self, filter: NSPredicate(format: "name CONTAINS[c] %@", "a")) var filteredItems
    @ObservedResults(Item.self, sortDescriptor: SortDescriptor.init(keyPath: "name", ascending: true)) var sortedItems

    @State private var searchText = ""
    @State private var isAToZ = true

    var body: some View {
        List {
            Toggle("sort order a to z", isOn: $isAToZ.animation())

            // random order
            ItemSectionView(title: "all")

            ItemSectionView(title: "sorted and filtered", searchText: searchText, isAToZ: isAToZ)
        }
        .searchable(text: $searchText.animation())
    }
}

private struct ItemSectionView: View {

    @ObservedResults(Item.self) var items

    let title: String

    init(title: String, searchText: String = "", isAToZ: Bool = true) {
        self.title = title

        if searchText.isEmpty {
            _items = ObservedResults(Item.self, sortDescriptor: SortDescriptor.init(keyPath: "name", ascending: isAToZ))
        } else {
            _items = ObservedResults(Item.self, filter: NSPredicate(format: "name CONTAINS[c] %@", searchText), sortDescriptor: SortDescriptor.init(keyPath: "name", ascending: isAToZ))
        }
    }

    var body: some View {
        Section(title) {
            ForEach(items) { item in
                ItemRowView(item: item)
            }
        }
    }
}

struct ItemResultView_Previews: PreviewProvider {
    static var previews: some View {

        return NavigationView {
            ItemResultView()
        }
        .environment(\.realm, RealmHelper.realmWithItems()) // inject realm to the view
        .previewLayout(.fixed(width: 400, height: 1500))
    }
}
