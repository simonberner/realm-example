//
//  GroupLoadingView.swift
//  RealmExample
//
//  Created by Simon Berner on 24.03.22.
//

import SwiftUI
import RealmSwift

struct GroupLoadingView: View {

    // Fetch all the group instances from the (local) Realm database
    @ObservedResults(Group.self) var groups

    var body: some View {
        if let group = groups.first {
            ItemListView(group: group)
        } else {
            ProgressView()
                .onAppear {
                    $groups.append(Group())
                }
        }
    }
}

struct GroupLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        GroupLoadingView()
    }
}
