//
//  ContentView.swift
//  RealmExample
//
//  Created by Simon Berner on 16.03.22.
//

import SwiftUI
import RealmSwift

struct ContentView: View {

    @ObservedObject var app: RealmSwift.App

    var body: some View {
        if let user = app.currentUser {
            RealmOpeningView()
                .environment(\.partitionValue, user.id) // see https://www.mongodb.com/docs/realm/sync/data-access-patterns/sync-mode/
        } else {
            LoginView()
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
