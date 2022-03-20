//
//  ItemResultView.swift
//  RealmExample
//
//  Created by Simon Berner on 18.03.22.
//

import SwiftUI
import RealmSwift

struct ItemResultView: View {

    @ObservedResults(Item.self) var items

    var body: some View {
        List {
            ForEach(items) { item in
                ItemRowView(item: item)
            }
        }
    }
}

struct ItemResultView_Previews: PreviewProvider {
    static var previews: some View {

        return ItemResultView()
            .environment(\.realm, RealmHelper.realmWithItems()) // inject realm to the view
    }
}
