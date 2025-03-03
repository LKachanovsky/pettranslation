//
//  TranslatorScreen.swift
//  pettranslation
//
//  Created by Leo Kachanovskyi on 26.02.2025.
//

import SwiftUI
import AVFoundation

struct TranslatorScreen: View {
    @Binding var showNavigationBar: Bool
    
    @StateObject var viewModel: TranslatorViewModel = TranslatorViewModel()
    @StateObject var audioManager: AudioRecorderManager = AudioRecorderManager()
    
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .setup(translationType: let translationType, selectedPet: let selectedPet, isRecording: let isRecording, isProcessing: let isProcessing):
                TranslationState(
                    translationType: translationType,
                    selectedPet: selectedPet,
                    isRecording: isRecording,
                    isProcessing: isProcessing,
                    handleEvent: { event in viewModel.handleEvent(event: event) }
                )
            case .result(pet: let pet, text: let text):
                ResultState(
                    pet: pet,
                    text: text,
                    handleEvent: { event in viewModel.handleEvent(event: event) }
                )
            }
        }
        .onChange(of: viewModel.state) { state in
            switch state {
            case .result(pet: let pet, text: let text): showNavigationBar = false
            default: showNavigationBar = true
            }
        }
        .onReceive(viewModel.effect) { effect in
            switch effect {
            case .askMicrophonePermission:
                askMicrophonePermission()
            case .showDeniedPermissionAlert:
                showPermissionDeniedAlert()
            case .startRecording:
                audioManager.startRecording(onStopRecording: { viewModel.handleEvent(event: .onStopRecording) })
            }
        }
    }
    
    func askMicrophonePermission() {
        let audioSession = AVAudioSession.sharedInstance()
            audioSession.requestRecordPermission { granted in
                DispatchQueue.main.async {
                    if granted {
                        viewModel.handleEvent(event: .onPermissionGranted)
                    } else {
                        viewModel.handleEvent(event: .onPermissionDenied)
                    }
                }
            }
    }
    
    func showPermissionDeniedAlert() {
        // Create the alert controller
        let alertController = UIAlertController(
            title: "Enable Microphone Access",
            message: "This app requires access to your microphone. Please enable it in Settings.",
            preferredStyle: .alert
        )
        
        // Create the Cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        // Create the Settings action, which opens the app's settings
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
            }
        }
        
        // Add the actions to the alert controller
        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
        
        // Present the alert controller
        if let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
           let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }),
           let rootVC = keyWindow.rootViewController {
            rootVC.present(alertController, animated: true, completion: nil)
        }
    }
}

#Preview {
    TranslatorScreen(
        showNavigationBar: .constant(true)
    )
}
