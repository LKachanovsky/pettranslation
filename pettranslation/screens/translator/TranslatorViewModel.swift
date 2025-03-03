//
//  TranslatorViewModel.swift
//  pettranslation
//
//  Created by Leo Kachanovskyi on 25.02.2025.
//

import Foundation
import Combine
import AVFoundation

class TranslatorViewModel: ObservableObject {
    @Published var state: TranslatorContract.State = .setup()
    @Published var effect = PassthroughSubject<TranslatorContract.Effect, Never>()
    
    private var selectedTranslationType: TranslationType = .humanToPet
    private var selectedPet: PetType = .dog
    
    func handleEvent(event: TranslatorContract.Event) {
        switch event {
        case .onTranslationIconClicked: onTranslationIconClicked()
        case .onPetTypeClicked(petType: let petType): onPetTypeClicked(petType: petType)
        case .onStartSpeakClicked: onStartSpeakClicked()
        case .onPermissionGranted: onPermissionGranted()
        case .onPermissionDenied: onPermissionDenied()
        case .onStopRecording: onStopRecording()
        case .onRepeatClicked: onRepeatClicked()
        case .onResultCloseClicked: onResultCloseClicked()
        }
    }
    
    private func onTranslationIconClicked() {
        let newValue: TranslationType = selectedTranslationType == .humanToPet ? .petToHuman : .humanToPet
        selectedTranslationType = newValue
        state = .setup(translationType: newValue, selectedPet: selectedPet)
    }
    
    private func onPetTypeClicked(petType: PetType) {
        selectedPet = petType
        state = .setup(translationType: selectedTranslationType, selectedPet: selectedPet)
    }
    
    private func onStartSpeakClicked() {
        let permissionStatus = AVAudioSession.sharedInstance().recordPermission

        switch permissionStatus {
        case .undetermined:
            effect.send(.askMicrophonePermission)
        case .denied:
            effect.send(.showDeniedPermissionAlert)
        case .granted:
            startRecording()
            
        @unknown default: break
            
        }
    }
    
    private func onPermissionGranted() {
        startRecording()
    }
    
    private func onStopRecording() {
        state = .setup(isProcessing: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.state = .result(pet: self.selectedPet, text: self.selectedPet.speechText)
        }
    }
    
    private func onPermissionDenied() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.effect.send(.showDeniedPermissionAlert)
        }
    }
    
    private func startRecording() {
        state = .setup(translationType: selectedTranslationType, selectedPet: selectedPet, isRecording: true)
        effect.send(.startRecording)
    }
    
    private func onRepeatClicked() {
        state = .setup(translationType: selectedTranslationType, selectedPet: selectedPet, isRecording: false, isProcessing: false)
    }
    
    private func onResultCloseClicked() {
        state = .setup(translationType: selectedTranslationType, selectedPet: selectedPet, isRecording: false, isProcessing: false)
    }
}
