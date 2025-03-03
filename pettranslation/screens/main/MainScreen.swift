//
//  MainScreen.swift
//  pettranslation
//
//  Created by Leo Kachanovskyi on 25.02.2025.
//

import SwiftUI

struct MainScreen: View {
    @StateObject var viewModel: MainViewModel = MainViewModel()
    
    @State var showNavigationBar: Bool = true
    
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .translator: TranslatorScreen(showNavigationBar: $showNavigationBar)
            case .settings: SettingsScreen()
            }
            
            VStack {
                Spacer()
                
                if showNavigationBar {
                    HStack(spacing: 42) {
                        Button(action: {
                            viewModel.handleEvent(event: .onTranslatorClicked)
                        }) {
                            VStack(spacing: 4) {
                                Image(.icTranslator)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 24)
                                
                                Text("Translator")
                            }
                            .opacity(viewModel.state == .translator ? 1 : 0.6)
                        }
                        
                        Button(action: {
                            viewModel.handleEvent(event: .onSettingsClicked)
                        }) {
                            VStack(spacing: 4) {
                                Image(.icSettings)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 24)
                                
                                Text("Settings")
                            }
                            .opacity(viewModel.state == .settings ? 1 : 0.6)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 19)
                    .background(.white)
                    .cornerRadius(16)
                    .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 5)
                    .padding(.bottom, 12)
                    .foregroundColor(._292_D_32)
                }
            }
            .font(.custom("KonkhmerSleokchher-Regular", size: 12))
        }
    }
}

#Preview {
    ZStack {
        LinearGradient(
            colors: [.F_3_F_5_F_6, .C_9_FFE_0],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
        MainScreen()
    }
}
