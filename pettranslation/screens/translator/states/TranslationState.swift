//
//  TranslationState.swift
//  pettranslation
//
//  Created by Leo Kachanovskyi on 25.02.2025.
//

import SwiftUI

struct TranslationState: View {
    let translationType: TranslationType
    let selectedPet: PetType
    let isRecording: Bool
    let isProcessing: Bool
    let handleEvent: (TranslatorContract.Event) -> Void
    
    var body: some View {
            VStack(spacing: 0) {
                Text("Translator")
                    .font(.custom("KonkhmerSleokchher-Regular", size: 32))
                    .padding(.top, 12)
                    .opacity(isProcessing ? 0 : 1)
                
                HStack(spacing: 8) {
                    Text(translationType == .humanToPet ? "HUMAN" : "PET")
                        .frame(width: 135)
                    
                    Button(action: {
                        handleEvent(.onTranslationIconClicked)
                    }) {
                        Image(.icTranslation)
                    }
                    
                    Text(translationType == .humanToPet ? "PET" : "HUMAN")
                        .frame(width: 135)
                }
                .padding(.top, 12)
                .padding(.vertical, 26)
                .opacity(isProcessing ? 0 : 1)
                
                HStack(spacing: 0) {
                    Button(action: {
                        handleEvent(.onStartSpeakClicked)
                    }) {
                        VStack(spacing: 24) {
                            if isRecording {
                                Spacer()
                                
                                RecordingAnimationView()
                                    .padding(.top, 16)
                                    .padding(.horizontal, 7.5)
                                
                                Spacer()
                                
                                Text("Recording...")
                                    .padding(.bottom, 16)
                            } else {
                                Spacer()
                                
                                Image(.icMic)
                                
                                Text("Start Speak")
                                    .padding(.horizontal)
                                    .padding(.bottom, 16)
                            }
                        }
                        .frame(width: 176, height: 178)
                        .background(Color.white)
                        .cornerRadius(16)
                        .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 5)
                        .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    Spacer(minLength: 35)
                    
                    VStack(spacing: 12) {
                        Button(action: {
                            handleEvent(.onPetTypeClicked(petType: .cat))
                        }) {
                            Image(PetType.cat.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40)
                                .padding(15)
                                .background(.D_1_E_7_FC)
                                .cornerRadius(8)
                                .opacity(selectedPet == .cat ? 1 : 0.6)
                        }
                        
                        Button(action: {
                            handleEvent(.onPetTypeClicked(petType: .dog))
                        }) {
                            Image(PetType.dog.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40)
                                .padding(15)
                                .background(.ECFBC_7)
                                .cornerRadius(8)
                                .opacity(selectedPet == .dog ? 1 : 0.6)
                        }
                    }
                    .padding(.horizontal, 18.5)
                    .padding(.vertical, 12)
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 5)
                    .fixedSize(horizontal: false, vertical: true)
                }
                .frame(minHeight: 0)
                .padding(.horizontal, 35)
                .padding(.top, 35)
                .opacity(isProcessing ? 0 : 1)
                
                Text("Process of translation...")
                    .opacity(isProcessing ? 1 : 0)
                
                Image(selectedPet.imageName)
                    .padding(.top, 51)
                
                Spacer()
                    .frame(minHeight: 134)
            }
            .font(.custom("KonkhmerSleokchher-Regular", size: 16))
            .foregroundColor(._292_D_32)
    }
}

struct RecordingAnimationView: View {
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<30, id: \.self) { _ in
                let startHeight = Int.random(in: 5...20)
                let initDelay = Double.random(in: 0...1)
                let animationDuration = Double.random(in: 1...1.5)
                StickAnimationView(startHeight: startHeight, initialDelay: initDelay, animationDuration: animationDuration)
            }
        }
    }
}

struct StickAnimationView: View {
    let startHeight: Int
    let initialDelay: Double
    let animationDuration: TimeInterval
    @State private var height: CGFloat = 5
    let minHeight: CGFloat = 5
    let maxHeight: CGFloat = 20

    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.blue)
                .frame(width: 1, height: height)
                .animation(.easeInOut(duration: animationDuration), value: height)
        }
        .onAppear {
            height = CGFloat(startHeight)
            DispatchQueue.main.asyncAfter(deadline: .now() + initialDelay) {
                startAnimating()
            }
        }
    }

    func startAnimating() {
        Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: true) { _ in
            withAnimation {
                height = (height == minHeight) ? maxHeight : minHeight
            }
        }
    }
}

#Preview {
    TranslationState(
        translationType: .humanToPet,
        selectedPet: .dog,
        isRecording: true,
        isProcessing: true,
        handleEvent: { _ in }
    )
}
