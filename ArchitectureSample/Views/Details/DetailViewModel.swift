//
//  DetailViewModel.swift
//  ArchitectureSample
//
//  Created by Steve Galbraith on 5/18/21.
//

import Foundation

enum Language: String, CaseIterable {
    case french = "French"
    case german = "German"
    case spanish = "Spanish"
}

final class DetailViewModel: ObservableObject {

    let option: NumberOption
    // When this property is updated (by the coordinator after user interaction) a re-draw of the view will occur
    @Published var selectedLanguage: Language = .french

    var translatedText: String {
        option.translated(to: selectedLanguage)
    }

    init(option: NumberOption) {
        self.option = option
    }
}

private extension NumberOption {
    func translated(to language: Language) -> String {
        switch language {
        case .french: return self.frenchTranslation
        case .german: return self.germanTranslation
        case .spanish: return self.spanishTranslation
        }
    }

    private var frenchTranslation: String {
        switch self {
        case .one: return "un"
        case .two: return "deux"
        case .three: return "trois"
        case .four: return "quatre"
        case .five: return "cinq"
        case .six: return "six"
        case .seven: return "sept"
        case .eight: return "huit"
        case .nine: return "neuf"
        case .ten: return "dix"
        case .eleven: return "onze"
        case .twelve: return "douze"
        case .thirteen: return "treize"
        case .fourteen: return "quatorze"
        case .fifteen: return "quinze"
        }
    }

    private var germanTranslation: String {
        switch self {
        case .one: return "eins"
        case .two: return "zwei"
        case .three: return "drei"
        case .four: return "vier"
        case .five: return "fünf"
        case .six: return "sechs"
        case .seven: return "sieben"
        case .eight: return "acht"
        case .nine: return "neun"
        case .ten: return "zehn"
        case .eleven: return "elf"
        case .twelve: return "zwölf"
        case .thirteen: return "dreizehn"
        case .fourteen: return "vierzehn"
        case .fifteen: return "fünfzehn"
        }
    }

    private var spanishTranslation: String {
        switch self {
        case .one: return "uno"
        case .two: return "dos"
        case .three: return "tres"
        case .four: return "cuatro"
        case .five: return "cinco"
        case .six: return "seis"
        case .seven: return "siete"
        case .eight: return "ocho"
        case .nine: return "nueve"
        case .ten: return "diez"
        case .eleven: return "once"
        case .twelve: return "doce"
        case .thirteen: return "trece"
        case .fourteen: return "catorce"
        case .fifteen: return "quince"
        }
    }
}
