//
//  RealmOpeningView.swift
//  RealmExample
//
//  Created by Simon Berner on 24.03.22.
//

import SwiftUI
import RealmSwift

struct RealmOpeningView: View {

    // always need newest data, does not work offline
//    @AsyncOpen(appId: "application-0-ezdqk", partitionValue: "", timeout: 4000) var asyncOpen

    // always show data also offline
    @AutoOpen(appId: "application-0-ezdqk", partitionValue: "", timeout: 4000) var realmOpen
    
    var body: some View {

        switch realmOpen {
            case .connecting:
                ProgressView("connecting ...")

            case .waitingForUser:
                ProgressView("waiting for user ...")

            case .progress(let progress):
                ProgressView(progress)
                    .padding(50)

            case .open(let realm):
                GroupLoadingView()
                    .environment(\.realm, realm) // the view and all its child-views shall use this realm database

            case .error(let error):
                Text("opening realm error: \(error.localizedDescription)")
        }
    }
}

struct RealmOpeningView_Previews: PreviewProvider {
    static var previews: some View {
        RealmOpeningView()
    }
}
