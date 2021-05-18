//
//  DetailCoodinator.swift
//  ArchitectureSample
//
//  Created by Steve Galbraith on 5/18/21.
//

import SwiftUI

final class DetailCoordinator {
    let viewModel: DetailViewModel

    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
    }
}

extension DetailCoordinator: Coordinator {
    // Creates the initial view
    func start() -> some View {
        DetailView(viewModel: viewModel, coordinator: self)
    }

    // All possible events (user or lifecycle generated) should be listed here
    enum Event {
        case select(Language)
    }

    // Allows the event to be passed to the coordinator so that the state can be updated
    func send(_ event: Event) {
        switch event {
        case .select(let language):
            viewModel.selectedLanguage = language
        }
    }
}
