//
//  HomeView.swift
//  ArchitectureSample
//
//  Created by Steve Galbraith on 5/18/21.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    let coordinator: HomeCoordinator

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                if viewModel.isLoading {
                    VStack {
                        ProgressView()
                    }
                } else {
                    ForEach(viewModel.options, id: \.self) { option in
                        NavigationLink(destination: coordinator.destination(for: option)) {
                            HomeRow(option: option)
                        }
                    }
                }

            }
        }
        .navigationTitle(viewModel.title)
        .onAppear {
            coordinator.send(.onAppear)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = HomeViewModel()
        let coordinator = HomeCoordinator(viewModel: viewModel)

        return HomeView(viewModel: viewModel, coordinator: coordinator)
    }
}

struct HomeRow: View {
    let option: NumberOption

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("\(option.rawValue)")
                    .font(.largeTitle)
                    .foregroundColor(Color(UIColor.systemBackground))
                    .frame(width: 40, height: 40)
                    .background(backgroundColor)
                    .padding(2)

                Text(option.description)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)

            }
            Divider().background(Color.primary)
        }
    }

    private var backgroundColor: Color {
        switch option.rawValue {
        case let value where value % 3 == 0:
            return .yellow
        case let value where value % 2 == 0:
            return .orange
        default:
            return .red
        }
    }
}
