//
//  HomeViewModel.swift
//  ArchitectureSample
//
//  Created by Steve Galbraith on 5/18/21.
//

import Foundation
import Combine

enum NumberOption: Int, CaseIterable {
    case one = 1
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
    case eleven
    case twelve
    case thirteen
    case fourteen
    case fifteen

    var description: String {
        switch self {
        case .one: return "One"
        case .two: return "Two"
        case .three: return "Three"
        case .four: return "Four"
        case .five: return "Five"
        case .six: return "Six"
        case .seven: return "Seven"
        case .eight: return "Eight"
        case .nine: return "Nine"
        case .ten: return "Ten"
        case .eleven: return "Eleven"
        case .twelve: return "Twelve"
        case .thirteen: return "Thirteen"
        case .fourteen: return "Fourteen"
        case .fifteen: return "Fifteen"
        }
    }
}

/// The view model  conforms to SwiftUI's `ObservableObject` protocol, which means that it will broadcast changes to any @Published properties to any subscribers (using the @ObservedObject protocol). 
final class HomeViewModel: ObservableObject {

    // When the `options` property is updated, it will trigger the `objectWillChange` in the ObservableObject protocol.
    // This causes anything that is observing the view model to update
    @Published var options = [NumberOption]()

    // Just like the above `@Published` property, when the value is updated it will cause any subscribers to redraw their view with the new data
    @Published var error: MockError?

    // This property will let the class know that the view has loaded and it is time to fetch the options.
    // It is a publisher that has a received type of Void and an error type of Never
    let viewAppeared = PassthroughSubject<Void, Never>()
    let title = "Home"

    // Stores the Publishers so that they don't go out of memory until the class is disposed of.
    // RX equivalent to dispose bag
    private var cancellables = Set<AnyCancellable>()

    var isLoading: Bool {
        options.isEmpty && error == nil
    }

    init() {
        setupSubscriptions()
    }

    private func setupSubscriptions() {
        // When the view appears, the `viewAppeared` property will fire and cause the options to be fetched
        viewAppeared
            .sink { [weak self] _ in self?.fetchOptions() }
            .store(in: &cancellables)
    }

    private func fetchOptions() {
        MockRequestManager.shared.send(.home)
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case .failure(let error) = completion {
                        self?.error = error
                    }
                },
                receiveValue: { [weak self] in
                    self?.options = $0
                }
            )
            .store(in: &cancellables)
    }
}
