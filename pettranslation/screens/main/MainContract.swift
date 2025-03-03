//
//  MainContract.swift
//  pettranslation
//
//  Created by Leo Kachanovskyi on 25.02.2025.
//

import Foundation

enum MainContract {
    enum State {
        case translator
        case settings
    }

    enum Event {
        case onTranslatorClicked
        case onSettingsClicked
    }
}
