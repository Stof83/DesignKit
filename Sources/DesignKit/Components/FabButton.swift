//
//  FabButton.swift
//
//
//  Created by El Mostafa El Ouatri on 16/10/23.
//

import SwiftUI

public struct FabButton: View {
    
    // MARK: - Public Properties
    let systemName: String?
    let image: Image?
    let background: Color
    let foregroundColor: Color
    let text: String?
    let badge: Int
    let badgeColor: Color
    let hasShadow: Bool
    let action: () -> Void
    
    // MARK: - Initialized
    public init(
        systemName: String? = nil,
        image: Image? = nil,
        background: Color,
        foregroundColor: Color,
        text: String? = nil,
        badge: Int = 0,
        badgeColor: Color = .red,
        hasShadow: Bool = true,
        action: @escaping () -> Void
    ) {
        self.systemName = systemName
        self.image = image
        self.background = background
        self.foregroundColor = foregroundColor
        self.text = text
        self.badge = badge
        self.badgeColor = badgeColor
        self.hasShadow = hasShadow
        self.action = action
    }
    
    // MARK: - Body
    public var body: some View {
        Button {
            action()
        } label: {
            VStack {
                Group {
                    if let systemName {
                        Image(systemName: systemName)
                    } else if let image {
                        image
                    }
                }
                .font(.system(size: 20))
                .padding()
                .frame(width: 40, height: 40)
                .background(background)
                .foregroundColor(foregroundColor)
                .clipShape(Circle())
                .if(hasShadow) { content in
                    content.shadow(radius: 4, x: 0, y: 4)
                }
                .overlay(badgeView, alignment: .topTrailing)
                
                if let text {
                    Text(text)
                        .font(.regular(fixedSize: 12))
                        .foregroundColor(background)
                        .multilineTextAlignment(.center)
                        .padding(.top, 10)
                }
            }
        }
        
    }
    
    private var badgeView: some View {
        Circle()
            .fill(badgeColor)
            .frame(width: 8, height: 8)
            .isHidden(badge == 0)
    }
}

struct FabButton_Previews: PreviewProvider {
    static var previews: some View {
        FabButton(
            systemName: "plus",
            background: .blue,
            foregroundColor: .white
        ) {}

    }
}

