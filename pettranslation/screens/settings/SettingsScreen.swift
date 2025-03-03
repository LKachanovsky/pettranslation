//
//  SettingsScreen.swift
//  pettranslation
//
//  Created by Leo Kachanovskyi on 27.02.2025.
//

import SwiftUI

struct SettingsScreen: View {
    var body: some View {
        VStack(spacing: 14) {
            Text("Settings")
                .font(.custom("KonkhmerSleokchher-Regular", size: 32))
                .padding(.top, 12)
            
            SettingsButton(title: "Rate Us")
            SettingsButton(title: "Share App")
            SettingsButton(title: "Contact Us")
            SettingsButton(title: "Restore Purchases")
            SettingsButton(title: "Privacy Policy")
            SettingsButton(title: "Terms of Use")
            
            Spacer()
        }
        .foregroundColor(._292_D_32)
        .padding(.horizontal, 16)
    }
}

struct SettingsButton: View {
    let title: String
    
    var body: some View {
        Button(action: {}) {
            HStack {
                Text(title)
                    .font(.custom("KonkhmerSleokchher-Regular", size: 16))
                    .foregroundColor(._292_D_32)
                
                Spacer()
                
                Image(.chevronRight)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24)
            }
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
            .background(.D_6_DCFF)
            .cornerRadius(16)
        }
    }
}

#Preview {
    SettingsScreen()
}
