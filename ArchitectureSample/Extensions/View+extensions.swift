//
//  View+extensions.swift
//  ArchitectureSample
//
//  Created by Steve Galbraith on 5/18/21.
//

import SwiftUI

extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}
