//
//  AudioRecorderManager.swift
//  pettranslation
//
//  Created by Leo Kachanovskyi on 27.02.2025.
//

import Foundation
import AVFoundation

class AudioRecorderManager: NSObject, ObservableObject {
    var audioRecorder: AVAudioRecorder?
    var silenceTimer: Timer?
    var silenceTime: TimeInterval = 0
    let silenceThreshold: Float = -40.0
    let requiredSilenceDuration: TimeInterval = 2.0 // seconds

    func startRecording(onStopRecording: @escaping () -> Void) {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)
            
            let settings: [String: Any] = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 12000,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            let tempDir = NSTemporaryDirectory()
            let fileName = "tempRecording.m4a"
            let fileURL = URL(fileURLWithPath: tempDir).appendingPathComponent(fileName)
            
            audioRecorder = try AVAudioRecorder(url: fileURL, settings: settings)
            audioRecorder?.isMeteringEnabled = true
            audioRecorder?.record()
            
            // Reset silence time and start timer
            silenceTime = 0
            silenceTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
                self?.checkForSilence(onStopRecording: onStopRecording)
                        }
        } catch {
            print("Failed to start recording: \(error.localizedDescription)")
        }
    }

    func checkForSilence(onStopRecording: @escaping () -> Void) {
        guard let recorder = audioRecorder, recorder.isRecording else { return }
        
        recorder.updateMeters()
        let currentPower = recorder.averagePower(forChannel: 0)
        
        if currentPower < silenceThreshold {
            silenceTime += 0.5
            if silenceTime >= requiredSilenceDuration {
                DispatchQueue.main.async { [weak self] in
                    self?.stopRecording()
                    onStopRecording()
                }
            }
        } else {
            silenceTime = 0
        }
    }

    func stopRecording() {
        silenceTimer?.invalidate()
        audioRecorder?.stop()
        audioRecorder = nil
        print("Recording stopped due to silence")
    }
}
