//
//  Navigator.swift
//  ArchitectureSample
//
//  Created by Steve Galbraith on 5/18/21.
//

import SwiftUI

protocol Navigator {
    associatedtype Destination
//    associatedtype Content: View

    /// The means of providing the next view by the conforming object
    /// - Parameter destination: A `Destination` as defined in the conforming object
    @ViewBuilder func view(for destination: Destination) -> AnyView
}

extension Navigator {
    func view(for destintion: DefaultDestination) -> AnyView {
        fatalError("Providing views must be handled in the conforming class, not by the default implementation")
    }
}

/// Placeholder for default implementaiton of `Navigator` - NOT MEANT FOR USE
enum DefaultDestination {
    case test
}
