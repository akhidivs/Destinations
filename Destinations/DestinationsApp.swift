//
//  DestinationsApp.swift
//  Destinations
//
//  Created by Akhilesh Mishra on 10/03/25.
//

import SwiftUI

@main
struct DestinationsApp: App {
    var body: some Scene {
        WindowGroup {
            LocationView()
                .environmentObject(LocationViewModel())
        }
    }
}
