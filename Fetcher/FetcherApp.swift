//
//  FetcherApp.swift
//  Fetcher
//
//  Created by Raheem Lawal on 2/20/24.
//

import SwiftUI

@main
struct FetcherApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
