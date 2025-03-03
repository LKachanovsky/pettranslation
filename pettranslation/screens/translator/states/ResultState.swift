//
//  ResultState.swift
//  pettranslation
//
//  Created by Leo Kachanovskyi on 25.02.2025.
//

import SwiftUI

struct ResultState: View {
    let pet: PetType
    let text: String?
    let handleEvent: (TranslatorContract.Event) -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Text("Result")
                    .font(.custom("KonkhmerSleokchher-Regular", size: 32))
                
                HStack {
                    Button(action: {
                        handleEvent(.onResultCloseClicked)
                    }) {
                        Image(.icClose)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 28)
                            .padding(10)
                            .background(.white)
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
            }
            .padding(.top, 12)
            
            ZStack(alignment: .top) {
                SpeechBubble()
                    .fill(.D_6_DCFF)
                    .shadow(color: .black.opacity(0.2), radius: 4, x: 2, y: 2)
                    .frame(maxWidth: .infinity)
                    .frame(height: 250)
                    .padding(.horizontal, 45)
                    .opacity(text == nil ? 0 : 1)
                
                Text(text ?? "")
                    .frame(height: 150)
                    .opacity(text == nil ? 0 : 1)
                
                Button(action: {
                    handleEvent(.onRepeatClicked)
                }) {
                    HStack(spacing: 10) {
                        Image(.icRepeat)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16)
                        
                        Text("Repeat")
                    }
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .background(.D_6_DCFF)
                    .cornerRadius(16)
                    .padding(.top, 88)
                    .padding(.horizontal, 49)
                    .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 5)
                }
                .opacity(text == nil ? 1 : 0)
            }
            .font(.custom("KonkhmerSleokchher-Regular", size: 12))
            .padding(.top, 91)
            
            Image(pet.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 184)
                .padding(.top, 24)
            
            Spacer()
        }
        .foregroundColor(._292_D_32)
    }
}

struct SpeechBubble: Shape {
    func path(in rect: CGRect) -> Path {
        let cornerRadius: CGFloat = 16
        let arrowWidth: CGFloat = 35
        let arrowHeight: CGFloat = 100
        let arrowRightPadding: CGFloat = 20
        let arrowPinSlide: CGFloat = 40
        
        var path = Path()
        
        // 1. Start at the top-left, just after the corner radius
        path.move(to: CGPoint(x: cornerRadius, y: 0))
        
        // 2. Top edge to top-right corner
        path.addLine(to: CGPoint(x: rect.width - cornerRadius, y: 0))
        
        // 3. Top-right rounded corner
        path.addArc(
            center: CGPoint(x: rect.width - cornerRadius, y: cornerRadius),
            radius: cornerRadius,
            startAngle: .degrees(-90),
            endAngle: .degrees(0),
            clockwise: false
        )
        
        // 4. Right edge down to bottom-right corner, above the arrow
        path.addLine(to: CGPoint(x: rect.width, y: rect.height - cornerRadius - arrowHeight))
        
        // 5. Bottom-right rounded corner (above the arrow)
        path.addArc(
            center: CGPoint(x: rect.width - cornerRadius, y: rect.height - cornerRadius - arrowHeight),
            radius: cornerRadius,
            startAngle: .degrees(0),
            endAngle: .degrees(90),
            clockwise: false
        )
        
        // 6. Bottom edge, stopping before the arrow
        path.addLine(to: CGPoint(x: rect.width - arrowWidth, y: rect.height - arrowHeight))
        
        // 7. Draw the arrow
        //    Move straight down, then diagonally back up to form a triangle
        path.addLine(to: CGPoint(x: rect.width - arrowWidth - arrowPinSlide, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width - arrowRightPadding, y: rect.height - arrowHeight))
        
        // 8. Continue the bottom edge to bottom-left corner
        path.addLine(to: CGPoint(x: cornerRadius, y: rect.height - arrowHeight))
        
        // 9. Bottom-left rounded corner
        path.addArc(
            center: CGPoint(x: cornerRadius, y: rect.height - cornerRadius - arrowHeight),
            radius: cornerRadius,
            startAngle: .degrees(90),
            endAngle: .degrees(180),
            clockwise: false
        )
        
        // 10. Left edge up to top-left corner
        path.addLine(to: CGPoint(x: 0, y: cornerRadius))
        
        // 11. Top-left rounded corner
        path.addArc(
            center: CGPoint(x: cornerRadius, y: cornerRadius),
            radius: cornerRadius,
            startAngle: .degrees(180),
            endAngle: .degrees(270),
            clockwise: false
        )
        
        return path
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
        
        ResultState(
            pet: .cat,
            text: nil,
            handleEvent: { _ in }
        )
    }
}
