//
//  MainViewModel.swift
//  pettranslation
//
//  Created by Leo Kachanovskyi on 25.02.2025.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var state: MainContract.State = .translator
    
    func handleEvent(event: MainContract.Event) {
        switch event {
        case .onTranslatorClicked:
            state = .translator
        case .onSettingsClicked:
            state = .settings
        }
    }
}
