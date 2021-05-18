//
//  DetailView.swift
//  ArchitectureSample
//
//  Created by Steve Galbraith on 5/18/21.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel: DetailViewModel
    let coordinator: DetailCoordinator
    @State var selectedLanguage: Language?

    var body: some View {
        VStack {
            Rectangle()
                .overlay(
                Text(viewModel.option.description)
                    .foregroundColor(Color(UIColor.systemBackground))
                    .font(.largeTitle)
            )

            VStack {
                Text(viewModel.translatedText)
                    .font(.title)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            HStack {
                ForEach(Language.allCases, id: \.self) { language in
                    Button(
                        action: {
                            // When the button is tapped, it will send the language to the coordinator with the event "select", passing the language
                            coordinator.send(.select(language))
                            // Set the state of the view to have the selected language to be able to highlight the button appropriately
                            selectedLanguage = language
                        },
                        label: {
                            Text(language.rawValue)
                                .padding(.horizontal)
                                .padding(.vertical, 6)
                                .foregroundColor(selectedLanguage == language ? Color(UIColor.systemBackground) : .primary)
                                .background(selectedLanguage == language ?  Color.blue : Color.clear)
                                .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.gray, lineWidth: 1))
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                                .padding(.bottom)
                        }
                    )
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            selectedLanguage = viewModel.selectedLanguage
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = DetailViewModel(option: .one)
        let coordinator = DetailCoordinator(viewModel: viewModel)

        return DetailView(viewModel: viewModel, coordinator: coordinator)
    }
}
