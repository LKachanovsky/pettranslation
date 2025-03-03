//
//  ContentView.swift
//  pettranslation
//
//  Created by Leo Kachanovskyi on 25.02.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
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
}

#Preview {
    ContentView()
}
