//
//  TranslatorContract.swift
//  pettranslation
//
//  Created by Leo Kachanovskyi on 25.02.2025.
//

import Foundation

enum TranslatorContract {
    enum State: Equatable {
        case setup(
            translationType: TranslationType = .humanToPet,
            selectedPet: PetType = .dog,
            isRecording: Bool = false,
            isProcessing: Bool = false
        )
        
        case result(
            pet: PetType,
            text: String?
        )
    }
    
    enum Event {
        case onTranslationIconClicked
        case onPetTypeClicked(petType: PetType)
        case onStartSpeakClicked
        case onPermissionGranted
        case onPermissionDenied
        case onStopRecording
        case onRepeatClicked
        case onResultCloseClicked
    }
    
    enum Effect {
        case askMicrophonePermission
        case showDeniedPermissionAlert
        case startRecording
    }
}

enum TranslationType {
    case humanToPet, petToHuman
}

//import SwiftUI
//import Combine
//
//// Define the effect types, similar to your sealed interfaces.
//enum Effect {
//    case showInter(event: String)
//    case navigateTo(NavigateTo)
//    
//    enum NavigateTo {
//        case home
//    }
//}
//
//// ViewModel using Combine to publish effects.
//final class BatteryViewModel: ObservableObject {
//    // Use a PassthroughSubject to emit side-effects.
//    let effectSubject = PassthroughSubject<Effect, Never>()
//    private var cancellables = Set<AnyCancellable>()
//    
//    init() {
//        // Send an initial effect, similar to your init block.
//        effectSubject.send(.showInter(event: "ads_int_\(AppFeature.batteryInfo.eventName)_2"))
//    }
//    
//    // Additional logic to send further effects can be added here.
//}
//
//// SwiftUI view that listens for effects.
//struct BatteryRoute: View {
//    @StateObject var viewModel = BatteryViewModel()
//    
//    var body: some View {
//        VStack {
//            // Your view content goes here.
//            Text("Battery Info")
//        }
//        // Subscribe to the effect publisher.
//        .onReceive(viewModel.effectSubject) { effect in
//            switch effect {
//            case .showInter(let event):
//                // Call your interstitial manager to show the ad.
//                interstitialManager.showInterstitial(
//                    // Assuming 'UIApplication.shared.windows.first?.rootViewController' is your current activity.
//                    viewController: UIApplication.shared.windows.first?.rootViewController,
//                    event: event
//                )
//            case .navigateTo(let destination):
//                switch destination {
//                case .home:
//                    // Navigate to home using your navigation abstraction.
//                    topLevelDestinations.home()
//                }
//            }
//        }
//    }
//}
