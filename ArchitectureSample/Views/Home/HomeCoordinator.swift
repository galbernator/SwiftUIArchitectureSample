//
//  HomeCoordinator.swift
//  ArchitectureSample
//
//  Created by Steve Galbraith on 5/18/21.
//

import SwiftUI

final class HomeCoordinator {
    let viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    // This provides the view for the navigation link so that the view does not know where it will go next
    func destination(for option: NumberOption) -> some View {
        view(for: .number(option.rawValue))
    }
}

extension HomeCoordinator: Coordinator {
    // This provies the initial view for the screen
    @ViewBuilder func start() -> some View {
        HomeView(viewModel: viewModel, coordinator: self)
    }

    // The list of all of the different events (user initiated or otherwise) that can happen on a screen
    enum Event {
        case onAppear
    }

    //
    func send(_ event: Event) {
        switch event {
        case .onAppear:
            viewModel.viewAppeared.send()
        }
    }

    // The list of all possible destinations from this view/coordinator
    enum Destination {
        case number(Int)
    }

    // Depending on the selected destination, the view is provied here
    // This method will be responsible for returning the view, but it is best to make it lazy.
    // If it is not lazy then the `body` property will be called before the view appears on
    // the new screen and possibly create the view before all the properties are ready.
    @ViewBuilder func view(for destination: Destination) -> some View {
        switch destination {
        case .number(let number):
            if let option = NumberOption(rawValue: number) {
                LazyView {
                    let viewModel = DetailViewModel(option: option)
                    let coordinator = DetailCoordinator(viewModel: viewModel)

                    coordinator.start()
                }
            } else {
                Text("Invalid destination")
            }
        }
    }
}
