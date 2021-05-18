//
//  ArchitectureSampleApp.swift
//  ArchitectureSample
//
//  Created by Steve Galbraith on 5/18/21.
//

import SwiftUI

@main
struct ArchitectureSampleApp: App {
    var body: some Scene {
        WindowGroup {
            // This is the pattern that is followed when creating initial or next views.
            // Create the Coordinator (and cooresponding view model is necessary) and call `start()` to provide the view
            let viewModel = HomeViewModel()
            let coordinator = HomeCoordinator(viewModel: viewModel)

            NavigationView {
                coordinator.start()
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
