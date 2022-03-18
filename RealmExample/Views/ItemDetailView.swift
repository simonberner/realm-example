//
//  ItemDetailView.swift
//  RealmExample
//
//  Created by Simon Berner on 16.03.22.
//

import SwiftUI
import RealmSwift

struct ItemDetailView: View {

    @ObservedRealmObject var item: Item

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
            ItemDetailView(item: Item())
        }
    }
}
